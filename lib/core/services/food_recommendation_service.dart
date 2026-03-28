import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/drift_database_service.dart';
import '../database/models/food_model.dart';
import '../database/models/user_food_history_model.dart';
import '../database/daos/drift_food_dao.dart';
import '../database/daos/drift_user_dao.dart';

/// Service for generating intelligent food recommendations
/// Uses Drift database for all platforms
/// TODO: Add DriftDailySummaryDao and DriftHealthLogDao for full functionality
class FoodRecommendationService {
  final DriftDatabaseService _dbService = DriftDatabaseService();
  final DriftFoodDao _foodDao = DriftFoodDao();
  final DriftUserDao _userDao = DriftUserDao();

  /// Get personalized food recommendations
  Future<List<FoodRecommendation>> getRecommendations({
    required int userId,
    String? timeOfDay,
    int limit = 20,
  }) async {
    final db = await _dbService.database;
    
    //get user context
    final user = await _userDao.getUserById(userId);
    if (user == null) {
      throw Exception('User not found');
    }

    //get today's summary using raw Drift query
    final today = DateTime.now().toIso8601String().split('T')[0];
    double consumedCarbs = 0.0;
    
    try {
      final summaryResult = await db.customSelect(
        'SELECT total_net_carbs_g FROM daily_summaries WHERE user_id = ? AND date = ?',
        variables: [Variable.withInt(userId), Variable.withString(today)],
      ).getSingleOrNull();
      
      if (summaryResult != null) {
        consumedCarbs = summaryResult.read<double?>('total_net_carbs_g') ?? 0.0;
      }
    } catch (e) {
      debugPrint('[RECOMMENDATION] Error fetching daily summary: $e');
    }
    
    final remainingCarbs = user.targetNetCarbs - consumedCarbs;

    //determine time of day if not provided
    final currentTimeOfDay = timeOfDay ?? _getTimeOfDay(DateTime.now());

    //get recent ketosis status (last 7 days) using raw query
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final startDate = sevenDaysAgo.toIso8601String().split('T')[0];
    double? avgGki;
    
    try {
      final gkiResult = await db.customSelect(
        'SELECT AVG(gki_score) as avg_gki FROM health_logs WHERE user_id = ? AND date >= ? AND date <= ? AND gki_score IS NOT NULL',
        variables: [Variable.withInt(userId), Variable.withString(startDate), Variable.withString(today)],
      ).getSingleOrNull();
      
      if (gkiResult != null) {
        avgGki = gkiResult.read<double?>('avg_gki');
      }
    } catch (e) {
      debugPrint('[RECOMMENDATION] Error fetching GKI: $e');
    }

    //get keto-friendly foods or foods that fit remaining carbs
    List<FoodModel> foods;
    try {
      if (remainingCarbs > 0) {
        //get foods that fit within remaining carbs using raw query
        final results = await db.customSelect('''
          SELECT * FROM foods 
          WHERE (net_carbs_g IS NOT NULL AND net_carbs_g <= ?)
             OR (net_carbs_g IS NULL AND (total_carbohydrate_g - dietary_fiber_g) <= ?)
          ORDER BY net_carbs_g ASC
          LIMIT 100
        ''', variables: [
          Variable.withReal(remainingCarbs),
          Variable.withReal(remainingCarbs),
        ]).get();
        
        foods = results.map((row) => FoodModel.fromMap(row.data)).toList();
      } else {
        //get keto-friendly foods
        foods = await _foodDao.getKetoFriendlyFoods(limit: 100);
      }
    } catch (e) {
      debugPrint('[RECOMMENDATION] Error fetching foods: $e');
      foods = [];
    }

    //score each food (without food history since table doesn't exist in Drift)
    final recommendations = <FoodRecommendation>[];
    for (final food in foods) {
      //calculate recommendation score without history data
      final score = _calculateRecommendationScore(
        food: food,
        history: null,
        timeOfDay: currentTimeOfDay,
        remainingCarbs: remainingCarbs,
        avgGki: avgGki,
      );

      recommendations.add(FoodRecommendation(
        food: food,
        recommendationScore: score,
        reasons: _getRecommendationReasons(
          food: food,
          history: null,
          timeOfDay: currentTimeOfDay,
          remainingCarbs: remainingCarbs,
          avgGki: avgGki,
        ),
      ));
    }

    //sort by score and limit
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

