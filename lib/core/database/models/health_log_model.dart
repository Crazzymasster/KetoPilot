/// Database model for tb_health_log table
class HealthLogModel {
  final int? logId;
  final int userId;
  final String recordedAt;
  final String date;
  final double? bloodGlucoseMgDl;
  final double? bloodKetonesMmolL;
  final double? gkiScore;
  final double? lactateMmolL;
  final double? sodiumMmolL;
  final int? bloodPressureSystolic;
  final int? bloodPressureDiastolic;
  final double? weightKg;
  final double? bodyFatPercentage;
  final double? muscleMassKg;
  final String source;
  final String? deviceId;
  final String? notes;
  final int synced;
  final String createdAt;

  HealthLogModel({
    this.logId,
    required this.userId,
    required this.recordedAt,
    required this.date,
    this.bloodGlucoseMgDl,
    this.bloodKetonesMmolL,
    this.gkiScore,
    this.lactateMmolL,
    this.sodiumMmolL,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.weightKg,
    this.bodyFatPercentage,
    this.muscleMassKg,
    this.source = 'manual',
    this.deviceId,
    this.notes,
    this.synced = 0,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (logId != null) 'log_id': logId,
      'user_id': userId,
      'recorded_at': recordedAt,
      'date': date,
      'blood_glucose_mg_dl': bloodGlucoseMgDl,
      'blood_ketones_mmol_l': bloodKetonesMmolL,
      'gki_score': gkiScore,
      'lactate_mmol_l': lactateMmolL,
      'sodium_mmol_l': sodiumMmolL,
      'blood_pressure_systolic': bloodPressureSystolic,
      'blood_pressure_diastolic': bloodPressureDiastolic,
      'weight_kg': weightKg,
      'body_fat_percentage': bodyFatPercentage,
      'muscle_mass_kg': muscleMassKg,
      'source': source,
      'device_id': deviceId,
      'notes': notes,
      'synced': synced,
      'created_at': createdAt,
    };
  }

  factory HealthLogModel.fromMap(Map<String, dynamic> map) {
    return HealthLogModel(
      logId: map['log_id'] as int?,
      userId: map['user_id'] as int,
      recordedAt: map['recorded_at'] as String,
      date: map['date'] as String,
      bloodGlucoseMgDl: map['blood_glucose_mg_dl'] as double?,
      bloodKetonesMmolL: map['blood_ketones_mmol_l'] as double?,
      gkiScore: map['gki_score'] as double?,
      lactateMmolL: map['lactate_mmol_l'] as double?,
      sodiumMmolL: map['sodium_mmol_l'] as double?,
      bloodPressureSystolic: map['blood_pressure_systolic'] as int?,
      bloodPressureDiastolic: map['blood_pressure_diastolic'] as int?,
      weightKg: map['weight_kg'] as double?,
      bodyFatPercentage: map['body_fat_percentage'] as double?,
      muscleMassKg: map['muscle_mass_kg'] as double?,
      source: map['source'] as String? ?? 'manual',
      deviceId: map['device_id'] as String?,
      notes: map['notes'] as String?,
      synced: map['synced'] as int? ?? 0,
      createdAt: map['created_at'] as String?,
    );
  }
}

