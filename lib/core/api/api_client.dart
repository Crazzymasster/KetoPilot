import 'package:dio/dio.dart';

/// Base API client for Keto Pilot
/// Handles authentication, error handling, and base configuration
class ApiClient {
  late final Dio _dio;
  String? _jwtToken;

  ApiClient({String? baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? 'https://api.ketopilot.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors for auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_jwtToken != null) {
          options.headers['Authorization'] = 'Bearer $_jwtToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Handle common errors
        if (error.response?.statusCode == 401) {
          // Token expired, handle refresh or logout
        }
        return handler.next(error);
      },
    ));
  }

  /// Set JWT token for authenticated requests
  void setAuthToken(String token) {
    _jwtToken = token;
  }

  /// Clear auth token
  void clearAuthToken() {
    _jwtToken = null;
  }

  /// Get Dio instance
  Dio get dio => _dio;
}

