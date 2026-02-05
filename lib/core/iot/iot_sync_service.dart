import 'dart:async';
import '../database/database_service.dart';
import '../database/models/health_log_model.dart';
import '../database/models/vitals_model.dart';
import '../database/daos/health_log_dao.dart';
import '../database/daos/vitals_dao.dart';
import 'device_interface.dart';
import 'models/biomarker_reading.dart';

/// Service for synchronizing IoT device data
class IoTSyncService {
  final DatabaseService _dbService;
  final List<BiosensorDevice> _devices;
  final Map<BiosensorDevice, StreamSubscription> _subscriptions = {};
  final HealthLogDao _healthLogDao = HealthLogDao();
  final VitalsDao _vitalsDao = VitalsDao();

  IoTSyncService(this._dbService, this._devices);

  /// Start real-time sync for all connected devices
  void startRealTimeSync(int userId) {
    for (final device in _devices) {
      if (device.isConnected) {
        _startDeviceSync(device, userId);
      }
    }
  }

  /// Start syncing a specific device
  void _startDeviceSync(BiosensorDevice device, int userId) {
    if (_subscriptions.containsKey(device)) {
      return; // Already syncing
    }

    final subscription = device.getReadings().listen(
      (reading) async {
        await _processReading(reading, userId);
      },
      onError: (error) {
        print('Error receiving readings from ${device.deviceType}: $error');
      },
    );

    _subscriptions[device] = subscription;
  }

  /// Process a biomarker reading and insert into database
  Future<void> _processReading(BiomarkerReading reading, int userId) async {
    final date = reading.timestamp.toIso8601String().split('T')[0];

    // Insert health log data
    if (reading.hasHealthLogData()) {
      final healthLog = HealthLogModel(
        userId: userId,
        recordedAt: reading.timestamp.toIso8601String(),
        date: date,
        bloodGlucoseMgDl: reading.bloodGlucoseMgDl,
        bloodKetonesMmolL: reading.bloodKetonesMmolL,
        lactateMmolL: reading.lactateMmolL,
        sodiumMmolL: reading.sodiumMmolL,
        bloodPressureSystolic: reading.bloodPressureSystolic,
        bloodPressureDiastolic: reading.bloodPressureDiastolic,
        weightKg: reading.weightKg,
        bodyFatPercentage: reading.bodyFatPercentage,
        muscleMassKg: reading.muscleMassKg,
        source: reading.source,
        deviceId: reading.deviceId,
        synced: 0,
      );

      await _healthLogDao.insertHealthLog(healthLog);
    }

    // Insert vitals data
    if (reading.hasVitalsData()) {
      final vitals = VitalsModel(
        userId: userId,
        recordedAt: reading.timestamp.toIso8601String(),
        date: date,
        heartRateBpm: reading.heartRate,
        hrvMs: reading.hrv,
        restingHeartRateBpm: reading.restingHeartRate,
        bodyTemperatureCelsius: reading.bodyTemperatureCelsius,
        skinTemperatureCelsius: reading.skinTemperatureCelsius,
        sleepDurationHours: reading.sleepDurationHours,
        deepSleepHours: reading.deepSleepHours,
        remSleepHours: reading.remSleepHours,
        lightSleepHours: reading.lightSleepHours,
        sleepScore: reading.sleepScore,
        stepsCount: reading.steps,
        activeCaloriesKcal: reading.activeCaloriesKcal,
        totalCaloriesKcal: reading.totalCaloriesKcal,
        distanceKm: reading.distanceKm,
        respiratoryRateBpm: reading.respiratoryRate,
        spo2Percentage: reading.spo2,
        source: reading.source,
        deviceId: reading.deviceId,
        synced: 0,
      );

      await _vitalsDao.insertVitals(vitals);
    }
  }

  /// Sync historical data on app startup
  Future<void> syncHistoricalData(int userId, DateTime since) async {
    final db = await _dbService.database;

    for (final device in _devices) {
      if (!device.isConnected) {
        continue;
      }

      try {
        final readings = await device.syncHistoricalData(since);

        // Batch insert with duplicate check
        await db.transaction((txn) async {
          for (final reading in readings) {
            final date = reading.timestamp.toIso8601String().split('T')[0];

            // Insert health log if applicable
            if (reading.hasHealthLogData()) {
              await txn.rawInsert('''
                INSERT OR IGNORE INTO tb_health_log 
                (user_id, recorded_at, date, blood_glucose_mg_dl, blood_ketones_mmol_l, 
                 source, device_id, synced)
                VALUES (?, ?, ?, ?, ?, ?, ?, 0)
              ''', [
                userId,
                reading.timestamp.toIso8601String(),
                date,
                reading.bloodGlucoseMgDl,
                reading.bloodKetonesMmolL,
                reading.source,
                reading.deviceId,
              ]);
            }

            // Insert vitals if applicable
            if (reading.hasVitalsData()) {
              await txn.rawInsert('''
                INSERT OR IGNORE INTO tb_vitals 
                (user_id, recorded_at, date, heart_rate_bpm, hrv_ms, steps_count,
                 source, device_id, synced)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)
              ''', [
                userId,
                reading.timestamp.toIso8601String(),
                date,
                reading.heartRate,
                reading.hrv,
                reading.steps,
                reading.source,
                reading.deviceId,
              ]);
            }
          }
        });
      } catch (e) {
        print('Error syncing device ${device.deviceType}: $e');
      }
    }
  }

  /// Stop real-time sync
  void stopRealTimeSync() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  /// Add a device
  void addDevice(BiosensorDevice device) {
    if (!_devices.contains(device)) {
      _devices.add(device);
    }
  }

  /// Remove a device
  void removeDevice(BiosensorDevice device) {
    _subscriptions[device]?.cancel();
    _subscriptions.remove(device);
    _devices.remove(device);
  }

  /// Disconnect all devices
  Future<void> disconnectAll() async {
    stopRealTimeSync();
    for (final device in _devices) {
      await device.disconnect();
    }
  }
}

