import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/food_recommendation_service.dart';

/// Provider for food recommendation service
final foodRecommendationServiceProvider = Provider<FoodRecommendationService>((ref) {
  return FoodRecommendationService();
});

/// Provider for food recommendations
final foodRecommendationsProvider = FutureProvider.family<List<FoodRecommendation>, String?>(
  (ref, timeOfDay) async {
    const userId = 1; // TODO: Get from auth provider
    final service = ref.watch(foodRecommendationServiceProvider);
    return service.getRecommendations(
      userId: userId,
      timeOfDay: timeOfDay,
      limit: 20,
    );
  },
);

