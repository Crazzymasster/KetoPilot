/// Database model for tb_daily_summary table
class DailySummaryModel {
  final int? summaryId;
  final int userId;
  final String date;
  final double totalEnergyKcal;
  final double totalProteinG;
  final double totalFatG;
  final double totalCarbohydrateG;
  final double totalNetCarbsG;
  final double totalFiberG;
  final double totalSodiumMg;
  final double totalPotassiumMg;
  final double totalMagnesiumMg;
  final int carbGoalMet;
  final int proteinGoalMet;
  final int fatGoalMet;
  final double? avgGlucoseMgDl;
  final double? avgKetonesMmolL;
  final double? avgGkiScore;
  final double? minGkiScore;
  final double? maxGkiScore;
  final int inKetosis;
  final int inTherapeuticKetosis;
  final int? avgHeartRateBpm;
  final double? avgHrvMs;
  final int? totalSteps;
  final double? weightKg;
  final double? weightChangeFromStartKg;
  final double? avgEnergyLevel;
  final double? avgMentalClarity;
  final double? avgMoodRating;
  final int dietEntriesCount;
  final int healthLogsCount;
  final String lastCalculatedAt;
  final int synced;

  DailySummaryModel({
    this.summaryId,
    required this.userId,
    required this.date,
    this.totalEnergyKcal = 0,
    this.totalProteinG = 0,
    this.totalFatG = 0,
    this.totalCarbohydrateG = 0,
    this.totalNetCarbsG = 0,
    this.totalFiberG = 0,
    this.totalSodiumMg = 0,
    this.totalPotassiumMg = 0,
    this.totalMagnesiumMg = 0,
    this.carbGoalMet = 0,
    this.proteinGoalMet = 0,
    this.fatGoalMet = 0,
    this.avgGlucoseMgDl,
    this.avgKetonesMmolL,
    this.avgGkiScore,
    this.minGkiScore,
    this.maxGkiScore,
    this.inKetosis = 0,
    this.inTherapeuticKetosis = 0,
    this.avgHeartRateBpm,
    this.avgHrvMs,
    this.totalSteps,
    this.weightKg,
    this.weightChangeFromStartKg,
    this.avgEnergyLevel,
    this.avgMentalClarity,
    this.avgMoodRating,
    this.dietEntriesCount = 0,
    this.healthLogsCount = 0,
    String? lastCalculatedAt,
    this.synced = 0,
  }) : lastCalculatedAt = lastCalculatedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (summaryId != null) 'summary_id': summaryId,
      'user_id': userId,
      'date': date,
      'total_energy_kcal': totalEnergyKcal,
      'total_protein_g': totalProteinG,
      'total_fat_g': totalFatG,
      'total_carbohydrate_g': totalCarbohydrateG,
      'total_net_carbs_g': totalNetCarbsG,
      'total_fiber_g': totalFiberG,
      'total_sodium_mg': totalSodiumMg,
      'total_potassium_mg': totalPotassiumMg,
      'total_magnesium_mg': totalMagnesiumMg,
      'carb_goal_met': carbGoalMet,
      'protein_goal_met': proteinGoalMet,
      'fat_goal_met': fatGoalMet,
      'avg_glucose_mg_dl': avgGlucoseMgDl,
      'avg_ketones_mmol_l': avgKetonesMmolL,
      'avg_gki_score': avgGkiScore,
      'min_gki_score': minGkiScore,
      'max_gki_score': maxGkiScore,
      'in_ketosis': inKetosis,
      'in_therapeutic_ketosis': inTherapeuticKetosis,
      'avg_heart_rate_bpm': avgHeartRateBpm,
      'avg_hrv_ms': avgHrvMs,
      'total_steps': totalSteps,
      'weight_kg': weightKg,
      'weight_change_from_start_kg': weightChangeFromStartKg,
      'avg_energy_level': avgEnergyLevel,
      'avg_mental_clarity': avgMentalClarity,
      'avg_mood_rating': avgMoodRating,
      'diet_entries_count': dietEntriesCount,
      'health_logs_count': healthLogsCount,
      'last_calculated_at': lastCalculatedAt,
      'synced': synced,
    };
  }

  factory DailySummaryModel.fromMap(Map<String, dynamic> map) {
    return DailySummaryModel(
      summaryId: map['summary_id'] as int?,
      userId: map['user_id'] as int,
      date: map['date'] as String,
      totalEnergyKcal: (map['total_energy_kcal'] as num?)?.toDouble() ?? 0,
      totalProteinG: (map['total_protein_g'] as num?)?.toDouble() ?? 0,
      totalFatG: (map['total_fat_g'] as num?)?.toDouble() ?? 0,
      totalCarbohydrateG: (map['total_carbohydrate_g'] as num?)?.toDouble() ?? 0,
      totalNetCarbsG: (map['total_net_carbs_g'] as num?)?.toDouble() ?? 0,
      totalFiberG: (map['total_fiber_g'] as num?)?.toDouble() ?? 0,
      totalSodiumMg: (map['total_sodium_mg'] as num?)?.toDouble() ?? 0,
      totalPotassiumMg: (map['total_potassium_mg'] as num?)?.toDouble() ?? 0,
      totalMagnesiumMg: (map['total_magnesium_mg'] as num?)?.toDouble() ?? 0,
      carbGoalMet: map['carb_goal_met'] as int? ?? 0,
      proteinGoalMet: map['protein_goal_met'] as int? ?? 0,
      fatGoalMet: map['fat_goal_met'] as int? ?? 0,
      avgGlucoseMgDl: map['avg_glucose_mg_dl'] as double?,
      avgKetonesMmolL: map['avg_ketones_mmol_l'] as double?,
      avgGkiScore: map['avg_gki_score'] as double?,
      minGkiScore: map['min_gki_score'] as double?,
      maxGkiScore: map['max_gki_score'] as double?,
      inKetosis: map['in_ketosis'] as int? ?? 0,
      inTherapeuticKetosis: map['in_therapeutic_ketosis'] as int? ?? 0,
      avgHeartRateBpm: map['avg_heart_rate_bpm'] as int?,
      avgHrvMs: map['avg_hrv_ms'] as double?,
      totalSteps: map['total_steps'] as int?,
      weightKg: map['weight_kg'] as double?,
      weightChangeFromStartKg: map['weight_change_from_start_kg'] as double?,
      avgEnergyLevel: map['avg_energy_level'] as double?,
      avgMentalClarity: map['avg_mental_clarity'] as double?,
      avgMoodRating: map['avg_mood_rating'] as double?,
      dietEntriesCount: map['diet_entries_count'] as int? ?? 0,
      healthLogsCount: map['health_logs_count'] as int? ?? 0,
      lastCalculatedAt: map['last_calculated_at'] as String?,
      synced: map['synced'] as int? ?? 0,
    );
  }
}

