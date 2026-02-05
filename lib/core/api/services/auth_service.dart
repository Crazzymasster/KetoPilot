import 'package:dio/dio.dart';
import '../api_client.dart';

/// Authentication API service
class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  /// Register a new user
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/auth/register',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data;
  }

  /// Verify email with verification code
  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/auth/verify-email',
      data: {
        'email': email,
        'verification_code': verificationCode,
      },
    );
    return response.data;
  }

  /// Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    
    // Set auth token if received
    if (response.data['jwt_token'] != null) {
      _apiClient.setAuthToken(response.data['jwt_token']);
    }
    
    return response.data;
  }

  /// Logout user
  Future<void> logout() async {
    _apiClient.clearAuthToken();
  }
}

