/// Time-to-ketosis analysis model
class TimeToKetosis {
  final int dayNumber;
  final double? avgGkiScore;
  final int inKetosis;
  final int inTherapeuticKetosis;
  final double totalNetCarbsG;
  final double? avgEnergyLevel;
  final String? milestone;

  TimeToKetosis({
    required this.dayNumber,
    this.avgGkiScore,
    required this.inKetosis,
    required this.inTherapeuticKetosis,
    required this.totalNetCarbsG,
    this.avgEnergyLevel,
    this.milestone,
  });

  factory TimeToKetosis.fromMap(Map<String, dynamic> map) {
    final dayNumber = map['day_number'] as int? ?? 0;
    final inTherapeuticKetosis = map['in_therapeutic_ketosis'] as int? ?? 0;
    final milestone = inTherapeuticKetosis == 1
        ? 'First achieved on day $dayNumber'
        : null;

    return TimeToKetosis(
      dayNumber: dayNumber,
      avgGkiScore: map['avg_gki_score'] as double?,
      inKetosis: map['in_ketosis'] as int? ?? 0,
      inTherapeuticKetosis: inTherapeuticKetosis,
      totalNetCarbsG: (map['total_net_carbs_g'] as num?)?.toDouble() ?? 0.0,
      avgEnergyLevel: map['avg_energy_level'] as double?,
      milestone: milestone,
    );
  }
}

