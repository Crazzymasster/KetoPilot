/// Model for biomarker readings from IoT devices
class BiomarkerReading {
  final String source; // 'oura_ring', 'apple_watch', 'cgm', 'bluetooth_meter'
  final DateTime timestamp;
  final String? deviceId;

  // Health log biomarkers
  final double? bloodGlucoseMgDl;
  final double? bloodKetonesMmolL;
  final double? lactateMmolL;
  final double? sodiumMmolL;
  final int? bloodPressureSystolic;
  final int? bloodPressureDiastolic;
  final double? weightKg;
  final double? bodyFatPercentage;
  final double? muscleMassKg;

  // Vitals
  final int? heartRate;
  final double? hrv; // Heart Rate Variability (RMSSD)
  final int? restingHeartRate;
  final double? bodyTemperatureCelsius;
  final double? skinTemperatureCelsius;
  final double? sleepDurationHours;
  final double? deepSleepHours;
  final double? remSleepHours;
  final double? lightSleepHours;
  final int? sleepScore;
  final int? steps;
  final double? activeCaloriesKcal;
  final double? totalCaloriesKcal;
  final double? distanceKm;
  final int? respiratoryRate;
  final double? spo2; // Blood oxygen saturation

  BiomarkerReading({
    required this.source,
    required this.timestamp,
    this.deviceId,
    this.bloodGlucoseMgDl,
    this.bloodKetonesMmolL,
    this.lactateMmolL,
    this.sodiumMmolL,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.weightKg,
    this.bodyFatPercentage,
    this.muscleMassKg,
    this.heartRate,
    this.hrv,
    this.restingHeartRate,
    this.bodyTemperatureCelsius,
    this.skinTemperatureCelsius,
    this.sleepDurationHours,
    this.deepSleepHours,
    this.remSleepHours,
    this.lightSleepHours,
    this.sleepScore,
    this.steps,
    this.activeCaloriesKcal,
    this.totalCaloriesKcal,
    this.distanceKm,
    this.respiratoryRate,
    this.spo2,
  });

  /// Check if reading has health log data
  bool hasHealthLogData() {
    return bloodGlucoseMgDl != null ||
        bloodKetonesMmolL != null ||
        weightKg != null ||
        bloodPressureSystolic != null;
  }

  /// Check if reading has vitals data
  bool hasVitalsData() {
    return heartRate != null ||
        hrv != null ||
        steps != null ||
        sleepDurationHours != null ||
        bodyTemperatureCelsius != null;
  }
}

