import 'package:sqflite/sqflite.dart';
import '../database/database_service.dart';
import '../database/models/food_model.dart';
import '../database/models/user_food_history_model.dart';
import '../database/daos/food_dao.dart';
import '../database/daos/user_dao.dart';
import '../database/daos/daily_summary_dao.dart';
import '../database/daos/health_log_dao.dart';
import '../database/daos/user_food_history_dao.dart';

/// Service for generating intelligent food recommendations
class FoodRecommendationService {
  final DatabaseService _dbService = DatabaseService();
  final FoodDao _foodDao = FoodDao();
  final UserDao _userDao = UserDao();
  final DailySummaryDao _summaryDao = DailySummaryDao();
  final HealthLogDao _healthLogDao = HealthLogDao();
  final UserFoodHistoryDao _foodHistoryDao = UserFoodHistoryDao();

  /// Get personalized food recommendations
  Future<List<FoodRecommendation>> getRecommendations({
    required int userId,
    String? timeOfDay,
    int limit = 20,
  }) async {
    final db = await _dbService.database;
    
    // Get user context
    final user = await _userDao.getUserById(userId);
    if (user == null) {
      throw Exception('User not found');
    }

    // Get today's summary
    final today = DateTime.now().toIso8601String().split('T')[0];
    final summary = await _summaryDao.getDailySummary(userId, today);
    final consumedCarbs = summary?.totalNetCarbsG ?? 0.0;
    final remainingCarbs = user.targetNetCarbs - consumedCarbs;

    // Determine time of day if not provided
    final currentTimeOfDay = timeOfDay ?? _getTimeOfDay(DateTime.now());

    // Get recent ketosis status (last 7 days)
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final startDate = sevenDaysAgo.toIso8601String().split('T')[0];
    final avgGki = await _healthLogDao.getAverageGki(userId, startDate, today);

    // Get keto-friendly foods or foods that fit remaining carbs
    final foods = await _foodDao.getFoodsByNetCarbs(
      maxNetCarbs: remainingCarbs > 0 ? remainingCarbs : null,
      limit: 100, // Get more to score and filter
    );

    // Score each food
    final recommendations = <FoodRecommendation>[];
    for (final food in foods) {
      // Get food history if exists
      final history = await _foodHistoryDao.getFoodHistory(userId, food.foodId ?? 0);
      
      // Calculate recommendation score
      final score = _calculateRecommendationScore(
        food: food,
        history: history,
        timeOfDay: currentTimeOfDay,
        remainingCarbs: remainingCarbs,
        avgGki: avgGki,
      );

      recommendations.add(FoodRecommendation(
        food: food,
        recommendationScore: score,
        reasons: _getRecommendationReasons(
          food: food,
          history: history,
          timeOfDay: currentTimeOfDay,
          remainingCarbs: remainingCarbs,
          avgGki: avgGki,
        ),
      ));
    }

    // Sort by score and limit
    recommendations.sort((a, b) => b.recommendationScore.compareTo(a.recommendationScore));
    return recommendations.take(limit).toList();
  }

  /// Calculate recommendation score for a food
  double _calculateRecommendationScore({
    required FoodModel food,
    UserFoodHistoryModel? history,
    required String timeOfDay,
    required double remainingCarbs,
    double? avgGki,
  }) {
    // Frequency score (30%)
    final frequencyScore = (history?.preferenceScore ?? 0.0) * 0.3;

    // Time match score (20%)
    int timeCount = 0;
    switch (timeOfDay) {
      case 'morning':
        timeCount = history?.morningCount ?? 0;
        break;
      case 'afternoon':
        timeCount = history?.afternoonCount ?? 0;
        break;
      case 'evening':
        timeCount = history?.eveningCount ?? 0;
        break;
      case 'night':
        timeCount = history?.nightCount ?? 0;
        break;
    }
    final timeMatchScore = timeCount * 0.2;

    // Macro fit score (30%)
    final netCarbs = food.netCarbsG ?? (food.totalCarbohydrateG - food.dietaryFiberG);
    final macroFitScore = (netCarbs <= remainingCarbs ? 1.0 : 0.5) * 0.3;

    // Ketosis score (20%)
    double ketosisScore = 0.5;
    if (avgGki != null) {
      if (avgGki < 6 && food.isKetoFriendly == 1) {
        ketosisScore = 1.0;
      } else if (avgGki >= 6 && netCarbs < 5) {
        ketosisScore = 0.8;
      }
    }
    ketosisScore *= 0.2;

    return frequencyScore + timeMatchScore + macroFitScore + ketosisScore;
  }

  /// Get reasons for recommendation
  List<String> _getRecommendationReasons({
    required FoodModel food,
    UserFoodHistoryModel? history,
    required String timeOfDay,
    required double remainingCarbs,
    double? avgGki,
  }) {
    final reasons = <String>[];
    final netCarbs = food.netCarbsG ?? (food.totalCarbohydrateG - food.dietaryFiberG);

    if (history != null && history.preferenceScore > 0.5) {
      reasons.add('frequently_consumed');
    }

    int timeCount = 0;
    switch (timeOfDay) {
      case 'morning':
        timeCount = history?.morningCount ?? 0;
        break;
      case 'afternoon':
        timeCount = history?.afternoonCount ?? 0;
        break;
      case 'evening':
        timeCount = history?.eveningCount ?? 0;
        break;
      case 'night':
        timeCount = history?.nightCount ?? 0;
        break;
    }
    if (timeCount > 0) {
      reasons.add('time_of_day_match');
    }

    if (netCarbs <= remainingCarbs) {
      reasons.add('fits_macros');
    }

    if (food.isKetoFriendly == 1) {
      reasons.add('keto_friendly');
    }

    return reasons;
  }

  /// Get time of day from DateTime
  String _getTimeOfDay(DateTime dateTime) {
    final hour = dateTime.hour;
    if (hour >= 5 && hour < 11) {
      return 'morning';
    } else if (hour >= 11 && hour < 17) {
      return 'afternoon';
    } else if (hour >= 17 && hour < 22) {
      return 'evening';
    } else {
      return 'night';
    }
  }
}

/// Food recommendation result
class FoodRecommendation {
  final FoodModel food;
  final double recommendationScore;
  final List<String> reasons;

  FoodRecommendation({
    required this.food,
    required this.recommendationScore,
    required this.reasons,
  });
}

