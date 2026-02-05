import 'package:dio/dio.dart';
import '../api_client.dart';

/// Health log API service
class HealthService {
  final ApiClient _apiClient;

  HealthService(this._apiClient);

  /// Create health log entry
  Future<Map<String, dynamic>> createHealthLog({
    required String recordedAt,
    double? bloodGlucoseMgDl,
    double? bloodKetonesMmolL,
    double? weightKg,
    String source = 'manual',
    Map<String, double>? molecules,
  }) async {
    final data = <String, dynamic>{
      'recorded_at': recordedAt,
      'source': source,
    };

    if (bloodGlucoseMgDl != null) data['blood_glucose_mg_dl'] = bloodGlucoseMgDl;
    if (bloodKetonesMmolL != null) data['blood_ketones_mmol_l'] = bloodKetonesMmolL;
    if (weightKg != null) data['weight_kg'] = weightKg;
    if (molecules != null) data['molecules'] = molecules;

    final response = await _apiClient.dio.post('/api/health/log', data: data);
    return response.data;
  }

  /// Get health logs
  Future<Map<String, dynamic>> getHealthLogs({
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = <String, dynamic>{};
    if (startDate != null) queryParams['start_date'] = startDate;
    if (endDate != null) queryParams['end_date'] = endDate;

    final response = await _apiClient.dio.get(
      '/api/health/log',
      queryParameters: queryParams,
    );
    return response.data;
  }

  /// Bulk upload molecules (for research)
  Future<Map<String, dynamic>> uploadMolecules({
    required String recordedAt,
    required Map<String, double> molecules,
    String source = 'cgm',
  }) async {
    final response = await _apiClient.dio.post(
      '/api/health/molecules',
      data: {
        'recorded_at': recordedAt,
        'molecules': molecules,
        'source': source,
      },
    );
    return response.data;
  }
}

