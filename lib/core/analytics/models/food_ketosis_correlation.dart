/// Food correlation with ketosis model
class FoodKetosisCorrelation {
  final int foodId;
  final String foodDescription;
  final int consumptionCount;
  final double avgGkiAfter;
  final double avgNetCarbs;
  final String ketosisImpact;

  FoodKetosisCorrelation({
    required this.foodId,
    required this.foodDescription,
    required this.consumptionCount,
    required this.avgGkiAfter,
    required this.avgNetCarbs,
    required this.ketosisImpact,
  });

  factory FoodKetosisCorrelation.fromMap(Map<String, dynamic> map) {
    final avgGki = (map['avg_gki_after'] as num?)?.toDouble() ?? 0.0;
    String impact;
    if (avgGki > 6) {
      impact = 'May disrupt ketosis';
    } else if (avgGki < 3) {
      impact = 'Supports deep ketosis';
    } else {
      impact = 'Neutral effect';
    }

    return FoodKetosisCorrelation(
      foodId: map['food_id'] as int,
      foodDescription: map['food_description'] as String,
      consumptionCount: map['consumption_count'] as int,
      avgGkiAfter: avgGki,
      avgNetCarbs: (map['avg_net_carbs'] as num?)?.toDouble() ?? 0.0,
      ketosisImpact: impact,
    );
  }
}

