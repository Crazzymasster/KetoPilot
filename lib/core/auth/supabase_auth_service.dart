import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../config/supabase_config.dart';

class AuthResult {
  final bool success;
  final User? user;
  final String? errorMessage;

  AuthResult({required this.success, this.user, this.errorMessage});
}

class SupabaseAuthService {
  final SupabaseService _supabaseService = SupabaseService();

  SupabaseClient get _client => _supabaseService.client;
  
  SupabaseClient get client => _supabaseService.client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<AuthResult> signUp({
    required String email,
    required String password,
    String? fullName,
    Map<String, dynamic>? userMetadata,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (userMetadata != null) {
        data.addAll(userMetadata);
      }
      if (fullName != null && fullName.trim().isNotEmpty) {
        data['full_name'] = fullName.trim();
      }

      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: data.isEmpty ? null : data,
      );

      if (response.user == null) {
        return AuthResult(
          success: false,
          errorMessage: 'Sign up failed. Please try again.',
        );
      }

      return AuthResult(success: true, user: response.user);
    } on AuthException catch (e) {
      return AuthResult(
        success: false,
        errorMessage: _formatAuthError(e.message),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return AuthResult(
          success: false,
          errorMessage: 'Invalid email or password.',
        );
      }

      return AuthResult(success: true, user: response.user);
    } on AuthException catch (e) {
      return AuthResult(
        success: false,
        errorMessage: _formatAuthError(e.message),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<AuthResult> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: SupabaseConfig.passwordResetRedirectUrl,
      );
      return AuthResult(success: true);
    } on AuthException catch (e) {
      return AuthResult(
        success: false,
        errorMessage: _formatAuthError(e.message),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Sends an OTP code to the specified phone number for password reset
  Future<AuthResult> sendPhoneOtp({required String phone}) async {
    try {
      // Format phone number to ensure it has country code
      final formattedPhone = _formatPhoneNumber(phone);
      
      await _client.auth.signInWithOtp(
        phone: formattedPhone,
      );
      return AuthResult(success: true);
    } on AuthException catch (e) {
      return AuthResult(
        success: false,
        errorMessage: _formatAuthError(e.message),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Verifies the OTP code sent to the phone number
  Future<AuthResult> verifyPhoneOtp({
    required String phone,
    required String token,
  }) async {
    try {
      final formattedPhone = _formatPhoneNumber(phone);
      
      final response = await _client.auth.verifyOTP(
        phone: formattedPhone,
        token: token,
        type: OtpType.sms,
      );
      
      if (response.user == null) {
        return AuthResult(
          success: false,
          errorMessage: 'Verification failed. Please try again.',
        );
      }
      
      return AuthResult(success: true, user: response.user);
    } on AuthException catch (e) {
      return AuthResult(
        success: false,
        errorMessage: _formatAuthError(e.message),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Updates the password for the currently authenticated user
  Future<AuthResult> updatePassword({required String newPassword}) async {
    try {
      final response = await _client.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      
      if (response.user == null) {
        return AuthResult(
          success: false,
          errorMessage: 'Password update failed. Please try again.',
        );
      }
      
      return AuthResult(success: true, user: response.user);
    } on AuthException catch (e) {
      return AuthResult(
        success: false,
        errorMessage: _formatAuthError(e.message),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  String _formatPhoneNumber(String phone) {
    // Remove any non-digit characters except + at the start
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // If it doesn't start with +, assume US and add +1
    if (!cleaned.startsWith('+')) {
      cleaned = '+1$cleaned';
    }
    
    return cleaned;
  }

  String _formatAuthError(String message) {
    if (message.toLowerCase().contains('invalid login credentials')) {
      return 'Invalid email or password.';
    } else if (message.toLowerCase().contains('email not confirmed')) {
      return 'Please verify your email before logging in.';
    } else if (message.toLowerCase().contains('user already registered')) {
      return 'An account with this email already exists.';
    }
    return message;
  }
}
