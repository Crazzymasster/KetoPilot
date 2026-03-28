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
  int get schemaVersion => 5;

  //Helper to safely add a column - tries Drift migrator first, falls back to raw SQL
  Future<void> _safeAddColumn(
    Migrator m,
    String tableName,
    String columnName,
    String columnType, {
    String? defaultValue,
  }) async {
    try {
      //Check if column already exists to avoid duplicate column errors
      final result = await customSelect(
        "PRAGMA table_info($tableName)",
      ).get();
      
      final columnExists = result.any(
        (row) => row.read<String>('name') == columnName,
      );
      
      if (columnExists) {
        // ignore: avoid_print
        print('[DRIFT DB] Column $columnName already exists in $tableName, skipping');
        return;
      }
      
      //Add column via raw SQL for maximum compatibility
      final defaultClause = defaultValue != null ? ' DEFAULT $defaultValue' : '';
      await customStatement(
        'ALTER TABLE $tableName ADD COLUMN $columnName $columnType$defaultClause',
      );
      // ignore: avoid_print
      print('[DRIFT DB] ✓ Added column $columnName to $tableName');
    } catch (e) {
      // ignore: avoid_print
      print('[DRIFT DB] ⚠ Migration warning for $tableName.$columnName: $e');
      //Column might already exist or table structure differs - continue gracefully
    }
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // ignore: avoid_print
        print('[DRIFT DB] Upgrading database from version $from to $to');
        
        //Migration from version 1 to 2: Add profile_setup_completed column
        if (from < 2) {
          await _safeAddColumn(
            m, 'users', 'profile_setup_completed', 'INTEGER',
            defaultValue: '0',
          );
        }
        
        //Migration from version 2 to 3: Add phone_number column
        if (from < 3) {
          await _safeAddColumn(m, 'users', 'phone_number', 'TEXT');
        }
        
        //Migration from version 3 to 4: Add cloud_id for diet entry sync
        if (from < 4) {
          await _safeAddColumn(m, 'tb_diet_entries', 'cloud_id', 'TEXT');
        }
        
        //Migration from version 4 to 5: Add sleep_quality for symptoms
        if (from < 5) {
          await _safeAddColumn(m, 'symptoms', 'sleep_quality', 'INTEGER');
        }
        
        // ignore: avoid_print
        print('[DRIFT DB] ✓ Migration complete');
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

