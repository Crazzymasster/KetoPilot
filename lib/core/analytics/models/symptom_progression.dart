/// Symptom progression over time model
class SymptomProgression {
  final String month;
  final double? avgHeadache;
  final double? avgFatigue;
  final double? avgBrainFog;
  final double? avgEnergy;
  final double? avgClarity;
  final double? avgMood;
  final double? avgGki;

  SymptomProgression({
    required this.month,
    this.avgHeadache,
    this.avgFatigue,
    this.avgBrainFog,
    this.avgEnergy,
    this.avgClarity,
    this.avgMood,
    this.avgGki,
  });

  factory SymptomProgression.fromMap(Map<String, dynamic> map) {
    return SymptomProgression(
      month: map['month'] as String,
      avgHeadache: map['avg_headache'] as double?,
      avgFatigue: map['avg_fatigue'] as double?,
      avgBrainFog: map['avg_brain_fog'] as double?,
      avgEnergy: map['avg_energy'] as double?,
      avgClarity: map['avg_clarity'] as double?,
      avgMood: map['avg_mood'] as double?,
      avgGki: map['avg_gki'] as double?,
    );
  }
}

