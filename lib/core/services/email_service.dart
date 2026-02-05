import 'package:flutter/foundation.dart' show debugPrint, kReleaseMode;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

//handles sending verification emails to users
//works in dev mode (console) or production (real emails)
class EmailService {
  static final EmailService _instance = EmailService._internal();
  factory EmailService() => _instance;
  EmailService._internal();

  //email server settings - you'll need to fill these in for production
  String? _smtpHost;
  int? _smtpPort;
  String? _smtpUsername;
  String? _smtpPassword;
  String? _fromEmail;
  String? _fromName;

  //call this to set up real email sending (like with Gmail)
  void configure({
    required String smtpHost,
    required int smtpPort,
    required String smtpUsername,
    required String smtpPassword,
    required String fromEmail,
    String fromName = 'KetoPilot',
  }) {
    _smtpHost = smtpHost;
    _smtpPort = smtpPort;
    _smtpUsername = smtpUsername;
    _smtpPassword = smtpPassword;
    _fromEmail = fromEmail;
    _fromName = fromName;
    debugPrint('✅ [EMAIL SERVICE] SMTP configured');
  }

  //check if we're ready to send real emails
  bool get isConfigured =>
      _smtpHost != null &&
      _smtpPort != null &&
      _smtpUsername != null &&
      _smtpPassword != null &&
      _fromEmail != null;

  //stores verification codes temporarily while waiting for user to verify
  final Map<String, String> _verificationCodes = {};
  final Map<String, DateTime> _codeExpiry = {};
  final Map<String, PendingSignup> _pendingSignups = {};
  
  //prevents spam by limiting how many emails someone can request
  final Map<String, List<DateTime>> _emailSendHistory = {};
  static const int _maxEmailsPerHour = 3;
  static const Duration _rateLimitWindow = Duration(hours: 1);

  //generates a random 6 digit code
  String _generateVerificationCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  //saves the signup info temporarily until they verify their email
  void storePendingSignup(String email, String password, String? fullName) {
    _pendingSignups[email] = PendingSignup(
      email: email,
      password: password,
      fullName: fullName,
      timestamp: DateTime.now(),
    );
    debugPrint('📝 [EMAIL SERVICE] Pending signup stored for $email');
  }

  //retrieves the signup info after they enter the code
  PendingSignup? getPendingSignup(String email) {
    return _pendingSignups[email];
  }

  //cleans up pending signup data after they register or time runs out
  void removePendingSignup(String email) {
    _pendingSignups.remove(email);
    debugPrint('🗑️ [EMAIL SERVICE] Pending signup removed for $email');
  }

  //checks if someone is trying to spam verification emails
  bool _isRateLimited(String email) {
    final now = DateTime.now();
    final history = _emailSendHistory[email] ?? [];
    
    //remove old attempts outside the 1 hour window
    history.removeWhere((timestamp) => 
      now.difference(timestamp) > _rateLimitWindow
    );
    
    _emailSendHistory[email] = history;
    
    //block if they've hit the limit
    if (history.length >= _maxEmailsPerHour) {
      final oldestAttempt = history.first;
      final timeUntilReset = _rateLimitWindow - now.difference(oldestAttempt);
      debugPrint('⏰ [EMAIL SERVICE] Rate limit exceeded for $email. Reset in ${timeUntilReset.inMinutes} minutes');
      return true;
    }
    
    return false;
  }

  //tracks when we send an email for rate limiting
  void _recordEmailSent(String email) {
    final history = _emailSendHistory[email] ?? [];
    history.add(DateTime.now());
    _emailSendHistory[email] = history;
  }

  //tells you how long until they can request another code
  Duration? getRateLimitReset(String email) {
    final history = _emailSendHistory[email];
    if (history == null || history.isEmpty) return null;
    
    final now = DateTime.now();
    final oldestAttempt = history.first;
    final timeSinceOldest = now.difference(oldestAttempt);
    
    if (timeSinceOldest < _rateLimitWindow && history.length >= _maxEmailsPerHour) {
      return _rateLimitWindow - timeSinceOldest;
    }
    
    return null;
  }

  //sends the verification email (returns null if successful, error message if not)
  Future<String?> sendVerificationEmail(String email) async {
    try {
      //stop spam attempts
      if (_isRateLimited(email)) {
        final resetTime = getRateLimitReset(email);
        final minutesRemaining = resetTime?.inMinutes ?? 0;
        return 'Too many verification emails sent. Please try again in $minutesRemaining minutes.';
      }

      final code = _generateVerificationCode();
      _verificationCodes[email] = code;
      _codeExpiry[email] = DateTime.now().add(const Duration(minutes: 10));
      
      _recordEmailSent(email);

      //send via SMTP if configured, otherwise just print to console
      if (isConfigured) {
        final success = await _sendProductionEmail(email, code);
        return success ? null : 'Failed to send email. Please try again.';
      } else {
        _sendDevelopmentEmail(email, code);
        return null;
      }
    } catch (e) {
      debugPrint('❌ [EMAIL SERVICE] Error sending email: $e');
      return 'An error occurred. Please try again.';
    }
  }

  //sends a real email using SMTP settings
  Future<bool> _sendProductionEmail(String email, String code) async {
    try {
      debugPrint('📧 [EMAIL SERVICE] Sending real email to $email...');
      
      final smtpServer = SmtpServer(
        _smtpHost!,
        port: _smtpPort!,
        username: _smtpUsername,
        password: _smtpPassword,
        ssl: _smtpPort == 465,
        allowInsecure: false,
      );

      final message = Message()
        ..from = Address(_fromEmail!, _fromName)
        ..recipients.add(email)
        ..subject = 'Verify your KetoPilot account'
        ..html = '''
          <!DOCTYPE html>
          <html>
          <head>
            <style>
              body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
              .container { max-width: 600px; margin: 0 auto; padding: 20px; }
              .header { background-color: #4CAF50; color: white; padding: 20px; text-align: center; border-radius: 5px 5px 0 0; }
              .content { background-color: #f9f9f9; padding: 30px; border: 1px solid #ddd; border-top: none; border-radius: 0 0 5px 5px; }
              .code { font-size: 32px; font-weight: bold; color: #4CAF50; text-align: center; padding: 20px; background-color: white; border-radius: 5px; margin: 20px 0; letter-spacing: 5px; }
              .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }
            </style>
          </head>
          <body>
            <div class="container">
              <div class="header">
                <h1>KetoPilot</h1>
              </div>
              <div class="content">
                <h2>Welcome to KetoPilot!</h2>
                <p>Thank you for signing up. Please verify your email address to complete your registration.</p>
                
                <p>Your verification code is:</p>
                <div class="code">$code</div>
                
                <p><strong>This code will expire in 10 minutes.</strong></p>
                
                <p>If you didn't request this code, please ignore this email.</p>
              </div>
              <div class="footer">
                <p>© 2025 KetoPilot. All rights reserved.</p>
              </div>
            </div>
          </body>
          </html>
        ''';

      final sendReport = await send(message, smtpServer);
      debugPrint('✅ [EMAIL SERVICE] Email sent successfully: ${sendReport.toString()}');
      return true;
    } catch (e) {
      debugPrint('❌ [EMAIL SERVICE] Failed to send email: $e');
      return _sendDevelopmentEmail(email, code);
    }
  }

  //prints the verification code to console for testing
  bool _sendDevelopmentEmail(String email, String code) {
    debugPrint('📧 [EMAIL SERVICE] Verification code for $email: $code');
    debugPrint('📧 [EMAIL SERVICE] Code expires in 10 minutes');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('📨 VERIFICATION EMAIL (Development Mode)');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('To: $email');
    debugPrint('Subject: Verify your KetoPilot account');
    debugPrint('');
    debugPrint('Your verification code is: $code');
    debugPrint('This code will expire in 10 minutes.');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    return true;
  }

  //checks if the code they entered is correct
  bool verifyCode(String email, String code) {
    try {
      final storedCode = _verificationCodes[email];
      final expiry = _codeExpiry[email];

      if (storedCode == null || expiry == null) {
        debugPrint('❌ [EMAIL SERVICE] No code found for $email');
        return false;
      }

      if (DateTime.now().isAfter(expiry)) {
        debugPrint('❌ [EMAIL SERVICE] Code expired for $email');
        _verificationCodes.remove(email);
        _codeExpiry.remove(email);
        removePendingSignup(email);
        return false;
      }

      if (storedCode == code) {
        debugPrint('✅ [EMAIL SERVICE] Code verified for $email');
        _verificationCodes.remove(email);
        _codeExpiry.remove(email);
        return true;
      }

      debugPrint('❌ [EMAIL SERVICE] Invalid code for $email');
      return false;
    } catch (e) {
      debugPrint('❌ [EMAIL SERVICE] Error verifying code: $e');
      return false;
    }
  }

  //sends another verification code
  Future<String?> resendVerificationCode(String email) async {
    return await sendVerificationEmail(email);
  }
}

//holds the signup info while waiting for email verification
class PendingSignup {
  final String email;
  final String password;
  final String? fullName;
  final DateTime timestamp;

  PendingSignup({
    required this.email,
    required this.password,
    this.fullName,
    required this.timestamp,
  });
}
