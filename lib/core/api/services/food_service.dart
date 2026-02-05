import 'package:dio/dio.dart';
import '../api_client.dart';

/// Food database API service
class FoodService {
  final ApiClient _apiClient;

  FoodService(this._apiClient);

  /// Search foods
  Future<Map<String, dynamic>> searchFoods({
    required String query,
    int limit = 20,
    bool? ketoFriendly,
  }) async {
    final queryParams = <String, dynamic>{
      'q': query,
      'limit': limit,
    };
    
    if (ketoFriendly != null) {
      queryParams['keto_friendly'] = ketoFriendly;
    }

    final response = await _apiClient.dio.get(
      '/api/food/search',
      queryParameters: queryParams,
    );
    return response.data;
  }

  /// Get food by ID
  Future<Map<String, dynamic>> getFoodById(int foodId) async {
    final response = await _apiClient.dio.get('/api/food/$foodId');
    return response.data;
  }

  /// Create user food
  Future<Map<String, dynamic>> createFood({
    required String foodDescription,
    required double energyKcal,
    required double totalProteinG,
    required double totalFatG,
    required double totalCarbohydrateG,
    double dietaryFiberG = 0,
    String? foodPhotoUrl,
    List<Map<String, dynamic>>? portions,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/food/create',
      data: {
        'food_description': foodDescription,
        'energy_kcal': energyKcal,
        'total_protein_g': totalProteinG,
        'total_fat_g': totalFatG,
        'total_carbohydrate_g': totalCarbohydrateG,
        'dietary_fiber_g': dietaryFiberG,
        if (foodPhotoUrl != null) 'food_photo_url': foodPhotoUrl,
        if (portions != null) 'portions': portions,
      },
    );
    return response.data;
  }

  /// Get food recommendations
  Future<Map<String, dynamic>> getRecommendations({
    String? timeOfDay,
    double? remainingCarbs,
  }) async {
    final queryParams = <String, dynamic>{};
    if (timeOfDay != null) queryParams['time_of_day'] = timeOfDay;
    if (remainingCarbs != null) queryParams['remaining_carbs'] = remainingCarbs;

    final response = await _apiClient.dio.get(
      '/api/food/recommendations',
      queryParameters: queryParams,
    );
    return response.data;
  }
}

