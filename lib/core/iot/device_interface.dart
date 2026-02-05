import 'models/biomarker_reading.dart';

/// Abstract interface for biosensor devices
abstract class BiosensorDevice {
  /// Device identifier
  String get deviceId;

  /// Device type/name
  String get deviceType;

  /// Connect to device
  Future<void> connect();

  /// Disconnect from device
  Future<void> disconnect();

  /// Check if device is connected
  bool get isConnected;

  /// Get real-time readings stream
  Stream<BiomarkerReading> getReadings();

  /// Sync historical data since a specific date
  Future<List<BiomarkerReading>> syncHistoricalData(DateTime since);

  /// Get device status
  Future<DeviceStatus> getStatus();
}

/// Device connection status
enum DeviceStatus {
  disconnected,
  connecting,
  connected,
  error,
}

