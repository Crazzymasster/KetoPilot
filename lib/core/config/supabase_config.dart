import 'env_config.dart';

class SupabaseConfig {
  // Use environment config for better security
  // Can be overridden with --dart-define=SUPABASE_URL=xxx --dart-define=SUPABASE_ANON_KEY=xxx
  static String get supabaseUrl => EnvConfig.supabaseUrl;
  static String get supabaseAnonKey => EnvConfig.supabaseAnonKey;
  
  // Site URL for email verification confirmation page
  static const String siteUrl = 'https://aquamarine-cassata-788350.netlify.app';
  
  /// Redirect URL for password reset - goes to separate reset page
  static const String passwordResetRedirectUrl = 'https://aquamarine-cassata-788350.netlify.app/reset-password.html';
}
