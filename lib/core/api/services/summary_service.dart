import 'package:dio/dio.dart';
import '../api_client.dart';

/// Daily summary API service
class SummaryService {
  final ApiClient _apiClient;

  SummaryService(this._apiClient);

  /// Get daily summary
  Future<Map<String, dynamic>> getDailySummary(String date) async {
    final response = await _apiClient.dio.get('/api/summary/daily/$date');
    return response.data;
  }

  /// Get weekly summary
  Future<Map<String, dynamic>> getWeeklySummary({String? startDate}) async {
    final queryParams = <String, dynamic>{};
    if (startDate != null) queryParams['start_date'] = startDate;

    final response = await _apiClient.dio.get(
      '/api/summary/weekly',
      queryParameters: queryParams,
    );
    return response.data;
  }
}

