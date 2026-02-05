import 'package:dio/dio.dart';
import '../api_client.dart';

/// Diet entry API service
class DietService {
  final ApiClient _apiClient;

  DietService(this._apiClient);

  /// Create a diet entry
  Future<Map<String, dynamic>> createDietEntry({
    required int foodId,
    required String recordedAt,
    int? portionId,
    double servingSizeMultiplier = 1.0,
    String? mealContext,
    String? foodPhotoUrl,
    String? notes,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/diet/entries',
      data: {
        'food_id': foodId,
        'recorded_at': recordedAt,
        if (portionId != null) 'portion_id': portionId,
        'serving_size_multiplier': servingSizeMultiplier,
        if (mealContext != null) 'meal_context': mealContext,
        if (foodPhotoUrl != null) 'food_photo_url': foodPhotoUrl,
        if (notes != null) 'notes': notes,
      },
    );
    return response.data;
  }

  /// Get diet entries
  Future<Map<String, dynamic>> getDietEntries({
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = <String, dynamic>{};
    if (startDate != null) queryParams['start_date'] = startDate;
    if (endDate != null) queryParams['end_date'] = endDate;

    final response = await _apiClient.dio.get(
      '/api/diet/entries',
      queryParameters: queryParams,
    );
    return response.data;
  }

  /// Delete diet entry
  Future<Map<String, dynamic>> deleteDietEntry(int entryId) async {
    final response = await _apiClient.dio.delete('/api/diet/entries/$entryId');
    return response.data;
  }
}

