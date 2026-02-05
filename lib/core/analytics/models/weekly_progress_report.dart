/// Weekly progress report model
class WeeklyProgressReport {
  final String week;
  final double avgNetCarbs;
  final double? avgGki;
  final double adherenceRate;
  final double? avgWeight;
  final double? minWeight;
  final double? maxWeight;
  final double? avgEnergy;
  final double? avgClarity;

  WeeklyProgressReport({
    required this.week,
    required this.avgNetCarbs,
    this.avgGki,
    required this.adherenceRate,
    this.avgWeight,
    this.minWeight,
    this.maxWeight,
    this.avgEnergy,
    this.avgClarity,
  });

  factory WeeklyProgressReport.fromMap(Map<String, dynamic> map) {
    return WeeklyProgressReport(
      week: map['week'] as String,
      avgNetCarbs: (map['avg_net_carbs'] as num?)?.toDouble() ?? 0.0,
      avgGki: map['avg_gki'] as double?,
      adherenceRate: (map['adherence_rate'] as num?)?.toDouble() ?? 0.0,
      avgWeight: map['avg_weight'] as double?,
      minWeight: map['min_weight'] as double?,
      maxWeight: map['max_weight'] as double?,
      avgEnergy: map['avg_energy'] as double?,
      avgClarity: map['avg_clarity'] as double?,
    );
  }
}

