import 'package:sqflite/sqflite.dart';
import '../database_service.dart';
import '../models/user_food_history_model.dart';

/// Data Access Object for tb_user_food_history table
class UserFoodHistoryDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert or update food history (upsert)
  Future<int> upsertFoodHistory(UserFoodHistoryModel history) async {
    final db = await _dbService.database;
    return await db.insert(
      'tb_user_food_history',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get food history by user and food
  Future<UserFoodHistoryModel?> getFoodHistory(int userId, int foodId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_user_food_history',
      where: 'user_id = ? AND food_id = ?',
      whereArgs: [userId, foodId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return UserFoodHistoryModel.fromMap(maps.first);
  }

  /// Get all food history for a user
  Future<List<UserFoodHistoryModel>> getFoodHistoryByUserId(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_user_food_history',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'preference_score DESC',
    );
    return maps.map((map) => UserFoodHistoryModel.fromMap(map)).toList();
  }

  /// Update food consumption (increment count and update time-of-day)
  Future<int> recordConsumption({
    required int userId,
    required int foodId,
    required DateTime consumedAt,
  }) async {
    // Get existing history or create new
    final existing = await getFoodHistory(userId, foodId);
    
    final hour = consumedAt.hour;
    int morningCount = existing?.morningCount ?? 0;
    int afternoonCount = existing?.afternoonCount ?? 0;
    int eveningCount = existing?.eveningCount ?? 0;
    int nightCount = existing?.nightCount ?? 0;

    // Update time-of-day count
    if (hour >= 5 && hour < 11) {
      morningCount++;
    } else if (hour >= 11 && hour < 17) {
      afternoonCount++;
    } else if (hour >= 17 && hour < 22) {
      eveningCount++;
    } else {
      nightCount++;
    }

    // Calculate preference score (exponential decay based on recency)
    final daysSinceConsumption = DateTime.now().difference(consumedAt).inDays;
    final preferenceScore = existing?.preferenceScore ?? 1.0;
    // Boost score for recent consumption, decay for older
    final newScore = daysSinceConsumption == 0 
        ? preferenceScore * 1.1  // Boost for today
        : preferenceScore * (0.95 * daysSinceConsumption); // Decay factor

    final history = UserFoodHistoryModel(
      historyId: existing?.historyId,
      userId: userId,
      foodId: foodId,
      totalConsumptionCount: (existing?.totalConsumptionCount ?? 0) + 1,
      lastConsumedAt: consumedAt.toIso8601String(),
      morningCount: morningCount,
      afternoonCount: afternoonCount,
      eveningCount: eveningCount,
      nightCount: nightCount,
      preferenceScore: newScore > 0 ? newScore : 0.1,
    );

    return await upsertFoodHistory(history);
  }

  /// Get recommended foods based on preference score and time of day
  Future<List<UserFoodHistoryModel>> getRecommendedFoods({
    required int userId,
    String? timeOfDay,
    int limit = 20,
  }) async {
    final db = await _dbService.database;
    
    String orderBy = 'preference_score DESC';
    if (timeOfDay != null) {
      // Boost foods consumed at this time of day
      final timeColumn = switch (timeOfDay) {
        'morning' => 'morning_count',
        'afternoon' => 'afternoon_count',
        'evening' => 'evening_count',
        'night' => 'night_count',
        _ => null,
      };
      if (timeColumn != null) {
        orderBy = '$timeColumn DESC, preference_score DESC';
      }
    }

    final maps = await db.query(
      'tb_user_food_history',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: orderBy,
      limit: limit,
    );
    return maps.map((map) => UserFoodHistoryModel.fromMap(map)).toList();
  }

  /// Delete food history
  Future<int> deleteFoodHistory(int userId, int foodId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_user_food_history',
      where: 'user_id = ? AND food_id = ?',
      whereArgs: [userId, foodId],
    );
  }
}

