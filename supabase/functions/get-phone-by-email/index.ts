import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function generateCode() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

function withCountryCode(phone: string) {
  return phone.startsWith("+") ? phone : `+1${phone.replace(/[^0-9]/g, "")}`;
}

async function sha256(data: string | ArrayBuffer): Promise<string> {
  const encoder = new TextEncoder();
  const dataBuffer = typeof data === "string" ? encoder.encode(data) : data;
  const hashBuffer = await crypto.subtle.digest("SHA-256", dataBuffer);
  return Array.from(new Uint8Array(hashBuffer))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

async function hmacSha256(key: string | ArrayBuffer, data: string): Promise<ArrayBuffer> {
  const encoder = new TextEncoder();
  const keyData = typeof key === "string" ? encoder.encode(key) : key;
  const keyObj = await crypto.subtle.importKey(
    "raw",
    keyData,
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"]
  );
  return await crypto.subtle.sign("HMAC", keyObj, encoder.encode(data));
}

async function sendSms(phoneNumber: string, code: string) {
  const accessKeyId = Deno.env.get("AWS_ACCESS_KEY_ID");
  const secretAccessKey = Deno.env.get("AWS_SECRET_ACCESS_KEY");
  const region = Deno.env.get("AWS_REGION") || "us-east-2";

  if (!accessKeyId || !secretAccessKey) {
    throw new Error("AWS credentials not configured");
  }

  console.log(`Sending SMS to ${phoneNumber} via AWS SNS`);

  const message = `Your KetoPilot password reset code is: ${code}`;
  const service = "sns";
  const host = `sns.${region}.amazonaws.com`;
  
  // Create timestamp
  const now = new Date();
  const amzDate = now.toISOString().replace(/[:\-]/g, "").split(".")[0] + "Z";
  const dateStamp = amzDate.slice(0, 8);

  // Create canonical query string
  const params: Record<string, string> = {
    Action: "Publish",
    Message: message,
    PhoneNumber: phoneNumber,
    Version: "2010-03-31",
  };

  const canonicalQuerystring = Object.keys(params)
    .sort()
    .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
    .join("&");

  // Create canonical request
  const payloadHash = await sha256("");
  const canonicalRequest = [
    "POST",
    "/",
    canonicalQuerystring,
    `host:${host}`,
    `x-amz-date:${amzDate}`,
    "",
    "host;x-amz-date",
    payloadHash
  ].join("\n");

  console.log("Canonical Request Created");

  // Hash the canonical request
  const canonicalRequestHash = await sha256(canonicalRequest);

  // Create string to sign
  const credentialScope = `${dateStamp}/${region}/${service}/aws4_request`;
  const stringToSign = [
    "AWS4-HMAC-SHA256",
    amzDate,
    credentialScope,
    canonicalRequestHash
  ].join("\n");

  console.log("String to Sign Created");

  // Calculate signature
  const kDate = await hmacSha256(`AWS4${secretAccessKey}`, dateStamp);
  const kRegion = await hmacSha256(kDate, region);
  const kService = await hmacSha256(kRegion, service);
  const kSigning = await hmacSha256(kService, "aws4_request");
  const signature = Array.from(new Uint8Array(await hmacSha256(kSigning, stringToSign)))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");

  console.log("Signature Calculated");

  // Create authorization header
  const authHeader = `AWS4-HMAC-SHA256 Credential=${accessKeyId}/${credentialScope}, SignedHeaders=host;x-amz-date, Signature=${signature}`;

  try {
    const response = await fetch(`https://${host}/?${canonicalQuerystring}`, {
      method: "POST",
      headers: {
        "X-Amz-Date": amzDate,
        "Authorization": authHeader,
        "Host": host,
      },
    });

    const responseText = await response.text();
    console.log(`AWS SNS Response: ${response.status}`);

    if (!response.ok) {
      console.error(`SNS Error: ${response.status} - ${responseText}`);
      throw new Error(`AWS SNS error: ${response.status}`);
    }

    console.log("SMS sent successfully");
  } catch (err) {
    console.error(`sendSms error: ${err.message}`);
    throw err;
  }
}

serve(async (req) => {
  // Handle CORS
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const { email } = await req.json();

    if (!email) {
      return new Response(JSON.stringify({ error: "Email is required" }), { status: 400, headers: corsHeaders });
    }

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );

    // Query the profiles table by email
    const { data: profile, error: queryError } = await supabase
      .from("profiles")
      .select("phone_number")
      .eq("email", email)
      .single();

    if (queryError) {
      console.error("Query error:", queryError);
      return new Response(JSON.stringify({ error: `User not found: ${queryError.message}` }), { status: 400, headers: corsHeaders });
    }

    if (!profile) {
      return new Response(JSON.stringify({ error: "User not found" }), { status: 400, headers: corsHeaders });
    }

    if (!profile.phone_number) {
      return new Response(JSON.stringify({ error: "User has no phone number on file" }), { status: 400, headers: corsHeaders });
    }

    const phone = withCountryCode(profile.phone_number);
    const code = generateCode();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000).toISOString(); // 10 min

    // Store code in DB
    const { error: insertError } = await supabase
      .from("password_reset_codes")
      .insert([{ email, phone, code, expires_at: expiresAt }]);

    if (insertError) {
      console.error("Insert error:", insertError);
      return new Response(JSON.stringify({ error: "Failed to store code" }), { status: 500, headers: corsHeaders });
    }

    try {
      await sendSms(phone, code);
    } catch (smsError) {
      console.error("SMS error:", smsError);
      return new Response(JSON.stringify({ error: "Failed to send SMS" }), { status: 500, headers: corsHeaders });
    }

    return new Response(JSON.stringify({ success: true, expires_at: expiresAt }), { status: 200, headers: corsHeaders });
  } catch (err) {
    console.error("Function error:", err);
    return new Response(JSON.stringify({ error: `Server error: ${err.message}` }), { status: 500, headers: corsHeaders });
  }
});