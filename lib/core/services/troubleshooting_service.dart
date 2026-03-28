import 'package:flutter/foundation.dart';
import '../database/drift_database_service.dart';

/// Service for troubleshooting common database issues
/// Uses Drift database for all platforms
class TroubleshootingService {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  /// Rebuild FTS5 index
  /// Note: FTS is not currently implemented in Drift - this is a no-op
  Future<void> rebuildFtsIndex() async {
    //FTS5 not available in Drift implementation
    //food search uses LIKE queries with caching instead
    debugPrint('[TROUBLESHOOTING] FTS rebuild skipped - using LIKE-based search');
  }

  /// Check if GKI trigger exists
  Future<bool> checkGkiTrigger() async {
    final db = await _dbService.database;
    final result = await db.customSelect('''
      SELECT name FROM sqlite_master 
      WHERE type='trigger' AND name='calculate_gki'
    ''').get();
    return result.isNotEmpty;
  }

  /// Manually recalculate GKI for all health logs
  /// Returns number of records that need GKI calculation
  Future<int> recalculateGki() async {
    final db = await _dbService.database;
    
    //first count how many records will be updated
    final countResult = await db.customSelect('''
      SELECT COUNT(*) as count FROM health_logs
      WHERE blood_glucose_mg_dl IS NOT NULL 
        AND blood_ketones_mmol_l > 0
        AND gki_score IS NULL
    ''').getSingle();
    final recordCount = countResult.read<int>('count');
    
    //perform the update
    await db.customStatement('''
      UPDATE health_logs
      SET gki_score = (blood_glucose_mg_dl / 18.0) / blood_ketones_mmol_l
      WHERE blood_glucose_mg_dl IS NOT NULL 
        AND blood_ketones_mmol_l > 0
        AND gki_score IS NULL
    ''');
    
    return recordCount;
  }

  /// Check if indexes exist
  Future<List<String>> checkIndexes() async {
    final db = await _dbService.database;
    final result = await db.customSelect('''
      SELECT name FROM sqlite_master 
      WHERE type='index' AND name NOT LIKE 'sqlite_%'
      ORDER BY name
    ''').get();
    return result.map((row) => row.read<String>('name')).toList();
  }

  /// Analyze query plan for a query
  Future<List<Map<String, dynamic>>> explainQueryPlan(String query) async {
    final db = await _dbService.database;
    final result = await db.customSelect('EXPLAIN QUERY PLAN $query').get();
    return result.map((row) => row.data).toList();
  }

  /// Optimize database (VACUUM and ANALYZE)
  Future<void> optimizeDatabase() async {
    final db = await _dbService.database;
    await db.customStatement('VACUUM');
    await db.customStatement('ANALYZE');
  }

  /// Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    final db = await _dbService.database;
    final stats = <String, dynamic>{};

    //Drift table names
    final tables = [
      'users',
      'foods',
      'diet_entries',
      'health_logs',
      'daily_summaries',
    ];

    for (final table in tables) {
      try {
        final result = await db.customSelect('SELECT COUNT(*) as count FROM $table').getSingle();
        stats['$table count'] = result.read<int>('count');
      } catch (e) {
        stats['$table count'] = 'error';
      }
    }

    //database page count (size indicator)
    try {
      final pageCount = await db.customSelect('PRAGMA page_count').getSingle();
      final pageSize = await db.customSelect('PRAGMA page_size').getSingle();
      final totalSize = pageCount.read<int>('page_count') * pageSize.read<int>('page_size');
      stats['database_size_bytes'] = totalSize;
      stats['database_size_mb'] = (totalSize / (1024 * 1024)).toStringAsFixed(2);
    } catch (e) {
      stats['database_size_bytes'] = 'error';
      stats['database_size_mb'] = 'error';
    }

    return stats;
  }

  /// Check for orphaned records (foreign key violations)
  Future<List<String>> checkOrphanedRecords() async {
    final db = await _dbService.database;
    final issues = <String>[];

    //check diet entries with invalid food_id
    final orphanedEntries = await db.customSelect('''
      SELECT de.entry_id, de.food_id
      FROM diet_entries de
      LEFT JOIN foods f ON de.food_id = f.food_id
      WHERE f.food_id IS NULL
    ''').get();

    if (orphanedEntries.isNotEmpty) {
      issues.add('Found ${orphanedEntries.length} diet entries with invalid food_id');
    }

    //check health logs with invalid user_id
    final orphanedLogs = await db.customSelect('''
      SELECT hl.log_id, hl.user_id
      FROM health_logs hl
      LEFT JOIN users u ON hl.user_id = u.user_id
      WHERE u.user_id IS NULL
    ''').get();

    if (orphanedLogs.isNotEmpty) {
      issues.add('Found ${orphanedLogs.length} health logs with invalid user_id');
    }

    return issues;
  }

  /// Fix orphaned records
  /// Returns approximate count of orphaned records
  Future<int> fixOrphanedRecords() async {
    final db = await _dbService.database;
    int fixed = 0;

    //count orphaned diet entries before deletion
    final orphanedEntriesCount = await db.customSelect('''
      SELECT COUNT(*) as count FROM diet_entries
      WHERE food_id NOT IN (SELECT food_id FROM foods)
    ''').getSingle();
    fixed += orphanedEntriesCount.read<int>('count');

    //delete orphaned diet entries
    await db.customStatement('''
      DELETE FROM diet_entries
      WHERE food_id NOT IN (SELECT food_id FROM foods)
    ''');

    //count orphaned health logs before deletion
    final orphanedLogsCount = await db.customSelect('''
      SELECT COUNT(*) as count FROM health_logs
      WHERE user_id NOT IN (SELECT user_id FROM users)
    ''').getSingle();
    fixed += orphanedLogsCount.read<int>('count');

    //delete orphaned health logs
    await db.customStatement('''
      DELETE FROM health_logs
      WHERE user_id NOT IN (SELECT user_id FROM users)
    ''');

    return fixed;
  }

  /// Verify data integrity
  Future<DataIntegrityReport> verifyDataIntegrity() async {
    final db = await _dbService.database;
    final report = DataIntegrityReport();

    //check foreign keys
    try {
      final fkViolations = await db.customSelect('PRAGMA foreign_key_check').get();
      report.foreignKeyViolations = fkViolations.length;
    } catch (e) {
      debugPrint('[TROUBLESHOOTING] FK check error: $e');
    }

    //check for null required fields
    try {
      final nullDescriptions = await db.customSelect('''
        SELECT COUNT(*) as count FROM foods WHERE food_description IS NULL
      ''').getSingle();
      report.nullRequiredFields = nullDescriptions.read<int>('count');
    } catch (e) {
      debugPrint('[TROUBLESHOOTING] Null check error: $e');
    }

    //check for invalid dates
    try {
      final invalidDates = await db.customSelect('''
        SELECT COUNT(*) as count FROM diet_entries 
        WHERE date NOT LIKE '____-__-__'
      ''').getSingle();
      report.invalidDates = invalidDates.read<int>('count');
    } catch (e) {
      debugPrint('[TROUBLESHOOTING] Date check error: $e');
    }

    //check orphaned records
    report.orphanedRecords = await checkOrphanedRecords();

    report.isHealthy = report.foreignKeyViolations == 0 &&
        report.nullRequiredFields == 0 &&
        report.invalidDates == 0 &&
        report.orphanedRecords.isEmpty;

    return report;
  }
}

/// Data integrity report
class DataIntegrityReport {
  int foreignKeyViolations = 0;
  int nullRequiredFields = 0;
  int invalidDates = 0;
  List<String> orphanedRecords = [];
  bool isHealthy = false;

  String getSummary() {
    final buffer = StringBuffer();
    buffer.writeln('=== Data Integrity Report ===\n');
    buffer.writeln('Foreign Key Violations: $foreignKeyViolations');
    buffer.writeln('Null Required Fields: $nullRequiredFields');
    buffer.writeln('Invalid Dates: $invalidDates');
    buffer.writeln('Orphaned Records: ${orphanedRecords.length}');
    if (orphanedRecords.isNotEmpty) {
      for (final record in orphanedRecords) {
        buffer.writeln('  - $record');
      }
    }
    buffer.writeln('\nOverall Status: ${isHealthy ? "✓ HEALTHY" : "✗ ISSUES FOUND"}');
    return buffer.toString();
  }
}

