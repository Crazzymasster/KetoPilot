/// Database model for tb_vitals table
class VitalsModel {
  final int? vitalId;
  final int userId;
  final String recordedAt;
  final String date;
  final int? heartRateBpm;
  final double? hrvMs;
  final int? restingHeartRateBpm;
  final double? bodyTemperatureCelsius;
  final double? skinTemperatureCelsius;
  final double? sleepDurationHours;
  final double? deepSleepHours;
  final double? remSleepHours;
  final double? lightSleepHours;
  final int? sleepScore;
  final int? stepsCount;
  final double? activeCaloriesKcal;
  final double? totalCaloriesKcal;
  final double? distanceKm;
  final int? respiratoryRateBpm;
  final double? spo2Percentage;
  final String source;
  final String? deviceId;
  final int synced;
  final String createdAt;

  VitalsModel({
    this.vitalId,
    required this.userId,
    required this.recordedAt,
    required this.date,
    this.heartRateBpm,
    this.hrvMs,
    this.restingHeartRateBpm,
    this.bodyTemperatureCelsius,
    this.skinTemperatureCelsius,
    this.sleepDurationHours,
    this.deepSleepHours,
    this.remSleepHours,
    this.lightSleepHours,
    this.sleepScore,
    this.stepsCount,
    this.activeCaloriesKcal,
    this.totalCaloriesKcal,
    this.distanceKm,
    this.respiratoryRateBpm,
    this.spo2Percentage,
    this.source = 'manual',
    this.deviceId,
    this.synced = 0,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      if (vitalId != null) 'vital_id': vitalId,
      'user_id': userId,
      'recorded_at': recordedAt,
      'date': date,
      'heart_rate_bpm': heartRateBpm,
      'hrv_ms': hrvMs,
      'resting_heart_rate_bpm': restingHeartRateBpm,
      'body_temperature_celsius': bodyTemperatureCelsius,
      'skin_temperature_celsius': skinTemperatureCelsius,
      'sleep_duration_hours': sleepDurationHours,
      'deep_sleep_hours': deepSleepHours,
      'rem_sleep_hours': remSleepHours,
      'light_sleep_hours': lightSleepHours,
      'sleep_score': sleepScore,
      'steps_count': stepsCount,
      'active_calories_kcal': activeCaloriesKcal,
      'total_calories_kcal': totalCaloriesKcal,
      'distance_km': distanceKm,
      'respiratory_rate_bpm': respiratoryRateBpm,
      'spo2_percentage': spo2Percentage,
      'source': source,
      'device_id': deviceId,
      'synced': synced,
      'created_at': createdAt,
    };
  }

  factory VitalsModel.fromMap(Map<String, dynamic> map) {
    return VitalsModel(
      vitalId: map['vital_id'] as int?,
      userId: map['user_id'] as int,
      recordedAt: map['recorded_at'] as String,
      date: map['date'] as String,
      heartRateBpm: map['heart_rate_bpm'] as int?,
      hrvMs: map['hrv_ms'] as double?,
      restingHeartRateBpm: map['resting_heart_rate_bpm'] as int?,
      bodyTemperatureCelsius: map['body_temperature_celsius'] as double?,
      skinTemperatureCelsius: map['skin_temperature_celsius'] as double?,
      sleepDurationHours: map['sleep_duration_hours'] as double?,
      deepSleepHours: map['deep_sleep_hours'] as double?,
      remSleepHours: map['rem_sleep_hours'] as double?,
      lightSleepHours: map['light_sleep_hours'] as double?,
      sleepScore: map['sleep_score'] as int?,
      stepsCount: map['steps_count'] as int?,
      activeCaloriesKcal: map['active_calories_kcal'] as double?,
      totalCaloriesKcal: map['total_calories_kcal'] as double?,
      distanceKm: map['distance_km'] as double?,
      respiratoryRateBpm: map['respiratory_rate_bpm'] as int?,
      spo2Percentage: map['spo2_percentage'] as double?,
      source: map['source'] as String? ?? 'manual',
      deviceId: map['device_id'] as String?,
      synced: map['synced'] as int? ?? 0,
      createdAt: map['created_at'] as String?,
    );
  }
}

