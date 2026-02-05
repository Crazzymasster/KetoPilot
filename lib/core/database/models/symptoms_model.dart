/// Database model for tb_symptoms table
class SymptomsModel {
  final int? symptomId;
  final int userId;
  final String recordedAt;
  final String date;
  final int? headacheSeverity;
  final int? fatigueSeverity;
  final int? nauseaSeverity;
  final int? dizzinessSeverity;
  final int? brainFogSeverity;
  final int? irritabilitySeverity;
  final int? muscleCrampsSeverity;
  final int? energyLevel;
  final int? mentalClarity;
  final int? moodRating;
  final int? hungerLevel;
  final int? satietyLevel;
  final int? bloatingSeverity;
  final int? digestionQuality;
  final String? customSymptoms; // JSON string
  final String? additionalNotes;
  final int synced;
  final String createdAt;

  SymptomsModel({
    this.symptomId,
    required this.userId,
    required this.recordedAt,
    required this.date,
    this.headacheSeverity,
    this.fatigueSeverity,
    this.nauseaSeverity,
    this.dizzinessSeverity,
    this.brainFogSeverity,
    this.irritabilitySeverity,
    this.muscleCrampsSeverity,
    this.energyLevel,
    this.mentalClarity,
    this.moodRating,
    this.hungerLevel,
    this.satietyLevel,
    this.bloatingSeverity,
    this.digestionQuality,
    this.customSymptoms,
    this.additionalNotes,
    this.synced = 0,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (symptomId != null) 'symptom_id': symptomId,
      'user_id': userId,
      'recorded_at': recordedAt,
      'date': date,
      'headache_severity': headacheSeverity,
      'fatigue_severity': fatigueSeverity,
      'nausea_severity': nauseaSeverity,
      'dizziness_severity': dizzinessSeverity,
      'brain_fog_severity': brainFogSeverity,
      'irritability_severity': irritabilitySeverity,
      'muscle_cramps_severity': muscleCrampsSeverity,
      'energy_level': energyLevel,
      'mental_clarity': mentalClarity,
      'mood_rating': moodRating,
      'hunger_level': hungerLevel,
      'satiety_level': satietyLevel,
      'bloating_severity': bloatingSeverity,
      'digestion_quality': digestionQuality,
      'custom_symptoms': customSymptoms,
      'additional_notes': additionalNotes,
      'synced': synced,
      'created_at': createdAt,
    };
  }

  factory SymptomsModel.fromMap(Map<String, dynamic> map) {
    return SymptomsModel(
      symptomId: map['symptom_id'] as int?,
      userId: map['user_id'] as int,
      recordedAt: map['recorded_at'] as String,
      date: map['date'] as String,
      headacheSeverity: map['headache_severity'] as int?,
      fatigueSeverity: map['fatigue_severity'] as int?,
      nauseaSeverity: map['nausea_severity'] as int?,
      dizzinessSeverity: map['dizziness_severity'] as int?,
      brainFogSeverity: map['brain_fog_severity'] as int?,
      irritabilitySeverity: map['irritability_severity'] as int?,
      muscleCrampsSeverity: map['muscle_cramps_severity'] as int?,
      energyLevel: map['energy_level'] as int?,
      mentalClarity: map['mental_clarity'] as int?,
      moodRating: map['mood_rating'] as int?,
      hungerLevel: map['hunger_level'] as int?,
      satietyLevel: map['satiety_level'] as int?,
      bloatingSeverity: map['bloating_severity'] as int?,
      digestionQuality: map['digestion_quality'] as int?,
      customSymptoms: map['custom_symptoms'] as String?,
      additionalNotes: map['additional_notes'] as String?,
      synced: map['synced'] as int? ?? 0,
      createdAt: map['created_at'] as String?,
    );
  }
}

