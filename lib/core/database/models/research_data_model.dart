/// Database model for tb_research_data table
class ResearchDataModel {
  final int? researchId;
  final String anonymousId;
  final int studyDay;
  final String date;
  final String? ageGroup;
  final String? genderCategory;
  final String? bmiCategory;
  final String? primaryCondition;
  final double? dailyNetCarbsG;
  final double? dailyProteinG;
  final double? dailyFatG;
  final double? dailyCaloriesKcal;
  final double? carbAdherenceRate;
  final double? avgGlucoseMgDl;
  final double? avgKetonesMmolL;
  final double? avgGkiScore;
  final double? ketosisPercentage;
  final double? weightChangeKg;
  final double? bodyFatChangePercentage;
  final double? avgEnergyLevel;
  final double? avgMentalClarity;
  final double? avgMoodRating;
  final double? ketoFluSeverityScore;
  final String createdAt;

  ResearchDataModel({
    this.researchId,
    required this.anonymousId,
    required this.studyDay,
    required this.date,
    this.ageGroup,
    this.genderCategory,
    this.bmiCategory,
    this.primaryCondition,
    this.dailyNetCarbsG,
    this.dailyProteinG,
    this.dailyFatG,
    this.dailyCaloriesKcal,
    this.carbAdherenceRate,
    this.avgGlucoseMgDl,
    this.avgKetonesMmolL,
    this.avgGkiScore,
    this.ketosisPercentage,
    this.weightChangeKg,
    this.bodyFatChangePercentage,
    this.avgEnergyLevel,
    this.avgMentalClarity,
    this.avgMoodRating,
    this.ketoFluSeverityScore,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (researchId != null) 'research_id': researchId,
      'anonymous_id': anonymousId,
      'study_day': studyDay,
      'date': date,
      'age_group': ageGroup,
      'gender_category': genderCategory,
      'bmi_category': bmiCategory,
      'primary_condition': primaryCondition,
      'daily_net_carbs_g': dailyNetCarbsG,
      'daily_protein_g': dailyProteinG,
      'daily_fat_g': dailyFatG,
      'daily_calories_kcal': dailyCaloriesKcal,
      'carb_adherence_rate': carbAdherenceRate,
      'avg_glucose_mg_dl': avgGlucoseMgDl,
      'avg_ketones_mmol_l': avgKetonesMmolL,
      'avg_gki_score': avgGkiScore,
      'ketosis_percentage': ketosisPercentage,
      'weight_change_kg': weightChangeKg,
      'body_fat_change_percentage': bodyFatChangePercentage,
      'avg_energy_level': avgEnergyLevel,
      'avg_mental_clarity': avgMentalClarity,
      'avg_mood_rating': avgMoodRating,
      'keto_flu_severity_score': ketoFluSeverityScore,
      'created_at': createdAt,
    };
  }

  factory ResearchDataModel.fromMap(Map<String, dynamic> map) {
    return ResearchDataModel(
      researchId: map['research_id'] as int?,
      anonymousId: map['anonymous_id'] as String,
      studyDay: map['study_day'] as int,
      date: map['date'] as String,
      ageGroup: map['age_group'] as String?,
      genderCategory: map['gender_category'] as String?,
      bmiCategory: map['bmi_category'] as String?,
      primaryCondition: map['primary_condition'] as String?,
      dailyNetCarbsG: map['daily_net_carbs_g'] as double?,
      dailyProteinG: map['daily_protein_g'] as double?,
      dailyFatG: map['daily_fat_g'] as double?,
      dailyCaloriesKcal: map['daily_calories_kcal'] as double?,
      carbAdherenceRate: map['carb_adherence_rate'] as double?,
      avgGlucoseMgDl: map['avg_glucose_mg_dl'] as double?,
      avgKetonesMmolL: map['avg_ketones_mmol_l'] as double?,
      avgGkiScore: map['avg_gki_score'] as double?,
      ketosisPercentage: map['ketosis_percentage'] as double?,
      weightChangeKg: map['weight_change_kg'] as double?,
      bodyFatChangePercentage: map['body_fat_change_percentage'] as double?,
      avgEnergyLevel: map['avg_energy_level'] as double?,
      avgMentalClarity: map['avg_mental_clarity'] as double?,
      avgMoodRating: map['avg_mood_rating'] as double?,
      ketoFluSeverityScore: map['keto_flu_severity_score'] as double?,
      createdAt: map['created_at'] as String?,
    );
  }
}

