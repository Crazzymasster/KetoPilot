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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migration from version 1 to 2: Add profile_setup_completed column
        if (from < 2) {
          await m.addColumn(users, users.profileSetupCompleted);
        }
        // Migration from version 2 to 3: Add phone_number column
        if (from < 3) {
          await m.addColumn(users, users.phoneNumber);
        }
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

