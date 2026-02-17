import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  // Handle CORS
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const { email, code } = await req.json();

    if (!email || !code) {
      return new Response(JSON.stringify({ error: "Email and code are required" }), { status: 400, headers: corsHeaders });
    }

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );

    // Check if code exists and hasn't expired
    const { data, error } = await supabase
      .from("password_reset_codes")
      .select("*")
      .eq("email", email)
      .eq("code", code)
      .eq("used", false)
      .gt("expires_at", new Date().toISOString())
      .order("created_at", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (error) {
      console.error("Query error:", error);
      return new Response(JSON.stringify({ success: false, error: `Query error: ${error.message}` }), { status: 400, headers: corsHeaders });
    }

    if (!data) {
      return new Response(JSON.stringify({ success: false, error: "Invalid or expired code" }), { status: 400, headers: corsHeaders });
    }

    // Mark code as used
    await supabase
      .from("password_reset_codes")
      .update({ used: true })
      .eq("id", data.id);

    return new Response(JSON.stringify({ success: true }), { status: 200, headers: corsHeaders });
  } catch (err) {
    console.error("Function error:", err);
    return new Response(JSON.stringify({ success: false, error: `Server error: ${err.message}` }), { status: 500, headers: corsHeaders });
  }
});