import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'drift_database.dart';

/// Cross-platform database service using Drift
/// Works on ALL platforms: iOS, Android, Web, Windows, macOS, Linux
class DriftDatabaseService {
  static DriftDatabaseService? _instance;
  static AppDatabase? _database;

  DriftDatabaseService._internal();

  factory DriftDatabaseService() {
    _instance ??= DriftDatabaseService._internal();
    return _instance!;
  }

  /// Get database instance (singleton)
  /// Lazy initialization - only creates when first accessed
  Future<AppDatabase> get database async {
    if (_database != null) {
      return _database!;
    }
    
    try {
      // Minimal logging for performance
      _database = await createDatabase();
      debugPrint('[DB SERVICE] ✅ Database ready (${kIsWeb ? "Web" : "Native"})');
      return _database!;
    } catch (e) {
      debugPrint('[DB SERVICE] ❌ Error: $e');
      rethrow;
    }
  }

  /// Check if running on web
  bool get isWeb => kIsWeb;

  /// Close database connection
  Future<void> close() async {
    try {
      debugPrint('[DB SERVICE] Closing database connection...');
      if (_database != null) {
        await _database!.close();
        _database = null;
        debugPrint('[DB SERVICE] ✅ Database connection closed');
      } else {
        debugPrint('[DB SERVICE] No database connection to close');
      }
    } catch (e) {
      debugPrint('[DB SERVICE] ❌ Error closing database: $e');
    }
  }

  /// Delete database (for testing/reset)
  Future<void> deleteDatabase() async {
    await close();
    if (!kIsWeb) {
      debugPrint('[DB SERVICE] Native platform - database file deletion not implemented');
      // On mobile/desktop, delete the file
      // Implementation depends on your needs
    } else {
      debugPrint('[DB SERVICE] Web platform - IndexedDB deletion not implemented');
      // On web, clear IndexedDB
      // Implementation depends on your needs
    }
  }
}



