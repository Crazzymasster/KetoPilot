import '../database/database_service.dart';
import '../database/database_schema.dart';

/// Service for deployment verification and checklist management
class DeploymentChecklistService {
  final DatabaseService _dbService = DatabaseService();

  /// Verify database schema
  Future<Map<String, bool>> verifySchema() async {
    final db = await _dbService.database;
    final checks = <String, bool>{};

    // Check all core tables exist
    final tables = [
      'tb_user',
      'tb_food',
      'tb_food_portions',
      'tb_diet_entries',
      'tb_health_log',
      'tb_vitals',
      'tb_symptoms',
      'tb_daily_summary',
      'tb_research_data',
      'tb_medications',
      'tb_medication_logs',
      'tb_user_food_history',
      'tb_food_creation_audit',
      'tb_photo_uploads',
    ];

    for (final table in tables) {
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [table],
      );
      checks['Table: $table'] = result.isNotEmpty;
    }

    // Check indexes exist
    final indexes = [
      'idx_user_email',
      'idx_diet_entries_user_date',
      'idx_health_log_user_date',
      'idx_daily_summary_user_date',
      'idx_food_keto_friendly',
    ];

    for (final index in indexes) {
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='index' AND name=?",
        [index],
      );
      checks['Index: $index'] = result.isNotEmpty;
    }

    // Check triggers exist
    final triggers = [
      'calculate_gki',
      'increment_food_counter',
      'populate_research_data',
    ];

    for (final trigger in triggers) {
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='trigger' AND name=?",
        [trigger],
      );
      checks['Trigger: $trigger'] = result.isNotEmpty;
    }

    return checks;
  }

  /// Verify foreign key constraints
  Future<bool> verifyForeignKeys() async {
    final db = await _dbService.database;
    
    // Enable foreign key checks
    await db.execute('PRAGMA foreign_keys = ON');
    
    // Try to insert invalid foreign key (should fail)
    try {
      await db.insert('tb_diet_entries', {
        'user_id': 99999, // Non-existent user
        'food_id': 1,
        'recorded_at': DateTime.now().toIso8601String(),
        'date': DateTime.now().toIso8601String().split('T')[0],
        'total_energy_kcal': 100.0,
        'total_protein_g': 10.0,
        'total_fat_g': 5.0,
        'total_carbohydrate_g': 5.0,
        'total_net_carbs_g': 3.0,
      });
      return false; // Should have failed
    } catch (e) {
      return true; // Foreign keys are working
    }
  }

  /// Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    final db = await _dbService.database;
    final stats = <String, dynamic>{};

    // Count records in each table
    final tables = [
      'tb_user',
      'tb_food',
      'tb_diet_entries',
      'tb_health_log',
      'tb_daily_summary',
    ];

    for (final table in tables) {
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM $table');
      stats['$table count'] = result.first['count'] as int;
    }

    // Database size
    final dbPath = await db.path;
    // Note: Actual file size would require file system access
    stats['database_path'] = dbPath;

    return stats;
  }

  /// Run all deployment checks
  Future<DeploymentChecklistResult> runAllChecks() async {
    final schemaChecks = await verifySchema();
    final foreignKeysOk = await verifyForeignKeys();
    final stats = await getDatabaseStats();

    final allPassed = schemaChecks.values.every((check) => check) && foreignKeysOk;

    return DeploymentChecklistResult(
      schemaChecks: schemaChecks,
      foreignKeysOk: foreignKeysOk,
      databaseStats: stats,
      allChecksPassed: allPassed,
    );
  }
}

/// Result of deployment checklist verification
class DeploymentChecklistResult {
  final Map<String, bool> schemaChecks;
  final bool foreignKeysOk;
  final Map<String, dynamic> databaseStats;
  final bool allChecksPassed;

  DeploymentChecklistResult({
    required this.schemaChecks,
    required this.foreignKeysOk,
    required this.databaseStats,
    required this.allChecksPassed,
  });

  /// Get summary report
  String getSummary() {
    final buffer = StringBuffer();
    buffer.writeln('=== Deployment Checklist Results ===\n');
    
    buffer.writeln('Schema Checks:');
    schemaChecks.forEach((check, passed) {
      buffer.writeln('  ${passed ? "✓" : "✗"} $check');
    });
    
    buffer.writeln('\nForeign Keys: ${foreignKeysOk ? "✓ OK" : "✗ FAILED"}');
    buffer.writeln('\nDatabase Stats:');
    databaseStats.forEach((key, value) {
      buffer.writeln('  $key: $value');
    });
    
    buffer.writeln('\nOverall Status: ${allChecksPassed ? "✓ ALL CHECKS PASSED" : "✗ SOME CHECKS FAILED"}');
    
    return buffer.toString();
  }
}

