/// Most consumed keto food model
class MostConsumedFood {
  final int foodId;
  final String foodDescription;
  final int timesConsumed;
  final double avgNetCarbsPerServing;
  final double totalNetCarbsConsumed;
  final String firstConsumed;
  final String lastConsumed;

  MostConsumedFood({
    required this.foodId,
    required this.foodDescription,
    required this.timesConsumed,
    required this.avgNetCarbsPerServing,
    required this.totalNetCarbsConsumed,
    required this.firstConsumed,
    required this.lastConsumed,
  });

  factory MostConsumedFood.fromMap(Map<String, dynamic> map) {
    return MostConsumedFood(
      foodId: map['food_id'] as int,
      foodDescription: map['food_description'] as String,
      timesConsumed: map['times_consumed'] as int,
      avgNetCarbsPerServing: (map['avg_net_carbs_per_serving'] as num?)?.toDouble() ?? 0.0,
      totalNetCarbsConsumed: (map['total_net_carbs_consumed'] as num?)?.toDouble() ?? 0.0,
      firstConsumed: map['first_consumed'] as String,
      lastConsumed: map['last_consumed'] as String,
    );
  }
}

