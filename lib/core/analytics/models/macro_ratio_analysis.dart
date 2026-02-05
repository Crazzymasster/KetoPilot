/// Macronutrient ratio analysis model
class MacroRatioAnalysis {
  final String carbRatioBucket;
  final int daysCount;
  final double? avgGki;
  final double? avgEnergy;
  final double? avgWeight;

  MacroRatioAnalysis({
    required this.carbRatioBucket,
    required this.daysCount,
    this.avgGki,
    this.avgEnergy,
    this.avgWeight,
  });

  factory MacroRatioAnalysis.fromMap(Map<String, dynamic> map) {
    return MacroRatioAnalysis(
      carbRatioBucket: map['carb_ratio_bucket'] as String,
      daysCount: map['days_count'] as int,
      avgGki: map['avg_gki'] as double?,
      avgEnergy: map['avg_energy'] as double?,
      avgWeight: map['avg_weight'] as double?,
    );
  }
}

