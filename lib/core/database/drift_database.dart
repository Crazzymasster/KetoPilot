import 'package:drift/drift.dart';
import 'drift_tables.dart';

// Conditional imports
import 'drift_database_stub.dart'
    if (dart.library.io) 'drift_database_native.dart'
    if (dart.library.html) 'drift_database_web.dart';

part 'drift_database.g.dart';

/// Cross-platform database using Drift
/// Works on: iOS, Android, Web, Windows, macOS, Linux
@DriftDatabase(tables: [
  Users,
  Foods,
  FoodPortions,
  DietEntries,
  HealthLogs,
  DailySummaries,
  Vitals,
  Symptoms,
  // Add more tables as needed (Medications, ResearchData, etc.)
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
      },
    );
  }
}

/// Factory function to create database for current platform
Future<AppDatabase> createDatabase() async {
  try {
    final executor = await createExecutor();
    final db = AppDatabase(executor);
    return db;
  } catch (e) {
    // ignore: avoid_print
    print('[DRIFT DB] ❌ Error: $e');
    rethrow;
  }
}

