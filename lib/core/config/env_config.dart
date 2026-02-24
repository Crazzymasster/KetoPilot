/// Environment configuration for sensitive values.
/// Use compile-time environment variables to inject secrets at build time.
/// 
/// Build with:
/// ```
/// flutter run --dart-define=GMAIL_EMAIL=your-email@gmail.com --dart-define=GMAIL_APP_PASSWORD=your-app-password
/// flutter build apk --dart-define=GMAIL_EMAIL=your-email@gmail.com --dart-define=GMAIL_APP_PASSWORD=your-app-password
/// ```
/// 
/// For CI/CD, set these as environment secrets in your GitHub Actions or build pipeline.
class EnvConfig {
  // Email configuration
  static const String gmailEmail = String.fromEnvironment(
    'GMAIL_EMAIL',
    defaultValue: '',
  );
  
  static const String gmailAppPassword = String.fromEnvironment(
    'GMAIL_APP_PASSWORD',
    defaultValue: '',
  );
  
  // Supabase configuration (can also be moved to env variables for extra security)
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://mfottufkpxxfozwgjinu.supabase.co',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1mb3R0dWZrcHh4Zm96d2dqaW51Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAyNTQ2MTUsImV4cCI6MjA4NTgzMDYxNX0.a-fLGmtkT_ahNk1z1uC3Dsav4SOhd0q8iry_WygvYts',
  );
  
  /// Check if production email is configured
  static bool get isEmailConfigured => 
      gmailEmail.isNotEmpty && gmailAppPassword.isNotEmpty;
  
  /// Validate that required config is present for production
  static void validateProductionConfig() {
    final missing = <String>[];
    
    if (gmailEmail.isEmpty) missing.add('GMAIL_EMAIL');
    if (gmailAppPassword.isEmpty) missing.add('GMAIL_APP_PASSWORD');
    
    if (missing.isNotEmpty) {
      throw Exception(
        'Missing required environment variables: ${missing.join(', ')}. '
        'Run with: flutter run --dart-define=GMAIL_EMAIL=xxx --dart-define=GMAIL_APP_PASSWORD=xxx'
      );
    }
  }
}
