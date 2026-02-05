/// Database model for tb_user_food_history table
class UserFoodHistoryModel {
  final int? historyId;
  final int userId;
  final int foodId;
  final int totalConsumptionCount;
  final String lastConsumedAt;
  final int morningCount;
  final int afternoonCount;
  final int eveningCount;
  final int nightCount;
  final double preferenceScore;
  final String updatedAt;

  UserFoodHistoryModel({
    this.historyId,
    required this.userId,
    required this.foodId,
    this.totalConsumptionCount = 1,
    required this.lastConsumedAt,
    this.morningCount = 0,
    this.afternoonCount = 0,
    this.eveningCount = 0,
    this.nightCount = 0,
    this.preferenceScore = 1.0,
    String? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (historyId != null) 'history_id': historyId,
      'user_id': userId,
      'food_id': foodId,
      'total_consumption_count': totalConsumptionCount,
      'last_consumed_at': lastConsumedAt,
      'morning_count': morningCount,
      'afternoon_count': afternoonCount,
      'evening_count': eveningCount,
      'night_count': nightCount,
      'preference_score': preferenceScore,
      'updated_at': updatedAt,
    };
  }

  factory UserFoodHistoryModel.fromMap(Map<String, dynamic> map) {
    return UserFoodHistoryModel(
      historyId: map['history_id'] as int?,
      userId: map['user_id'] as int,
      foodId: map['food_id'] as int,
      totalConsumptionCount: map['total_consumption_count'] as int? ?? 1,
      lastConsumedAt: map['last_consumed_at'] as String,
      morningCount: map['morning_count'] as int? ?? 0,
      afternoonCount: map['afternoon_count'] as int? ?? 0,
      eveningCount: map['evening_count'] as int? ?? 0,
      nightCount: map['night_count'] as int? ?? 0,
      preferenceScore: (map['preference_score'] as num?)?.toDouble() ?? 1.0,
      updatedAt: map['updated_at'] as String?,
    );
  }
}

