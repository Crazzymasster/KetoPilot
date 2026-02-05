import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../device_interface.dart';
import '../models/biomarker_reading.dart';

/// Oura Ring device implementation
class OuraRingDevice implements BiosensorDevice {
  final String accessToken;
  final http.Client client;
  bool _isConnected = false;
  StreamController<BiomarkerReading>? _readingsController;
  Timer? _pollTimer;

  OuraRingDevice(this.accessToken, this.client);

  @override
  String get deviceId => 'oura_ring_${accessToken.substring(0, 8)}';

  @override
  String get deviceType => 'oura_ring';

  @override
  bool get isConnected => _isConnected;

  @override
  Future<void> connect() async {
    try {
      // Verify token by making a test request
      final response = await client.get(
        Uri.parse('https://api.ouraring.com/v2/usercollection/personal_info'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        _isConnected = true;
        _readingsController = StreamController<BiomarkerReading>.broadcast();
      } else {
        throw Exception('Failed to connect to Oura Ring: ${response.statusCode}');
      }
    } catch (e) {
      _isConnected = false;
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    _pollTimer?.cancel();
    await _readingsController?.close();
    _readingsController = null;
    _isConnected = false;
  }

  @override
  Stream<BiomarkerReading> getReadings() {
    if (!_isConnected) {
      throw Exception('Device not connected');
    }

    if (_readingsController == null) {
      _startPolling();
    }

    return _readingsController!.stream;
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      try {
        // Get daily readiness data
        final readinessResponse = await client.get(
          Uri.parse('https://api.ouraring.com/v2/usercollection/daily_readiness'),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (readinessResponse.statusCode == 200) {
          final data = json.decode(readinessResponse.body);
          if (data['data'] != null && data['data'].isNotEmpty) {
            final latest = data['data'][0];
            final contributors = latest['contributors'] ?? {};

            final reading = BiomarkerReading(
              source: 'oura_ring',
              timestamp: DateTime.now(),
              deviceId: deviceId,
              heartRate: contributors['resting_heart_rate']?.toInt(),
              hrv: contributors['hrv_balance']?.toDouble(),
              sleepScore: latest['score']?.toInt(),
            );

            _readingsController?.add(reading);
          }
        }

        // Get sleep data
        final sleepResponse = await client.get(
          Uri.parse('https://api.ouraring.com/v2/usercollection/daily_sleep'),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (sleepResponse.statusCode == 200) {
          final sleepData = json.decode(sleepResponse.body);
          if (sleepData['data'] != null && sleepData['data'].isNotEmpty) {
            final latest = sleepData['data'][0];
            final reading = BiomarkerReading(
              source: 'oura_ring',
              timestamp: DateTime.now(),
              deviceId: deviceId,
              sleepDurationHours: latest['duration']?.toDouble() / 3600,
              deepSleepHours: latest['deep_sleep_duration']?.toDouble() / 3600,
              remSleepHours: latest['rem_sleep_duration']?.toDouble() / 3600,
              lightSleepHours: latest['light_sleep_duration']?.toDouble() / 3600,
              sleepScore: latest['score']?.toInt(),
            );

            _readingsController?.add(reading);
          }
        }
      } catch (e) {
        // Handle errors silently or log them
        print('Error polling Oura Ring: $e');
      }
    });
  }

  @override
  Future<List<BiomarkerReading>> syncHistoricalData(DateTime since) async {
    final readings = <BiomarkerReading>[];

    try {
      // Get sleep data
      final sleepResponse = await client.get(
        Uri.parse(
          'https://api.ouraring.com/v2/usercollection/daily_sleep?start_date=${since.toIso8601String().split('T')[0]}',
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (sleepResponse.statusCode == 200) {
        final data = json.decode(sleepResponse.body);
        if (data['data'] != null) {
          for (final item in data['data']) {
            readings.add(BiomarkerReading(
              source: 'oura_ring',
              timestamp: DateTime.parse(item['timestamp']),
              deviceId: deviceId,
              sleepDurationHours: item['duration']?.toDouble() / 3600,
              deepSleepHours: item['deep_sleep_duration']?.toDouble() / 3600,
              remSleepHours: item['rem_sleep_duration']?.toDouble() / 3600,
              lightSleepHours: item['light_sleep_duration']?.toDouble() / 3600,
              sleepScore: item['score']?.toInt(),
            ));
          }
        }
      }

      // Get activity data
      final activityResponse = await client.get(
        Uri.parse(
          'https://api.ouraring.com/v2/usercollection/daily_activity?start_date=${since.toIso8601String().split('T')[0]}',
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (activityResponse.statusCode == 200) {
        final data = json.decode(activityResponse.body);
        if (data['data'] != null) {
          for (final item in data['data']) {
            readings.add(BiomarkerReading(
              source: 'oura_ring',
              timestamp: DateTime.parse(item['timestamp']),
              deviceId: deviceId,
              steps: item['steps']?.toInt(),
              activeCaloriesKcal: item['active_calories']?.toDouble(),
              totalCaloriesKcal: item['total_calories']?.toDouble(),
              distanceKm: item['distance']?.toDouble() / 1000, // Convert meters to km
            ));
          }
        }
      }
    } catch (e) {
      print('Error syncing Oura Ring historical data: $e');
    }

    return readings;
  }

  @override
  Future<DeviceStatus> getStatus() async {
    if (!_isConnected) {
      return DeviceStatus.disconnected;
    }

    try {
      final response = await client.get(
        Uri.parse('https://api.ouraring.com/v2/usercollection/personal_info'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        return DeviceStatus.connected;
      } else {
        return DeviceStatus.error;
      }
    } catch (e) {
      return DeviceStatus.error;
    }
  }
}

