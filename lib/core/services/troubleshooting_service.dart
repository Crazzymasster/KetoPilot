import '../database/database_service.dart';

/// Service for troubleshooting common database issues
class TroubleshootingService {
  final DatabaseService _dbService = DatabaseService();

  /// Rebuild FTS5 index
  Future<void> rebuildFtsIndex() async {
    final db = await _dbService.database;
    
    // Delete existing FTS data
    await db.execute('DELETE FROM tb_food_fts');
    
    // Rebuild from main table
    await db.execute('''
      INSERT INTO tb_food_fts(rowid, food_description, keylist)
      SELECT food_id, food_description, keylist FROM tb_food
    ''');
  }

  /// Check if GKI trigger exists
  Future<bool> checkGkiTrigger() async {
    final db = await _dbService.database;
    final result = await db.rawQuery('''
      SELECT name FROM sqlite_master 
      WHERE type='trigger' AND name='calculate_gki'
    ''');
    return result.isNotEmpty;
  }

  /// Manually recalculate GKI for all health logs
  Future<int> recalculateGki() async {
    final db = await _dbService.database;
    return await db.rawUpdate('''
      UPDATE tb_health_log
      SET gki_score = (blood_glucose_mg_dl / 18.0) / blood_ketones_mmol_l
      WHERE blood_glucose_mg_dl IS NOT NULL 
        AND blood_ketones_mmol_l > 0
        AND gki_score IS NULL
    ''');
  }

  /// Check if indexes exist
  Future<List<String>> checkIndexes() async {
    final db = await _dbService.database;
    final result = await db.rawQuery('''
      SELECT name FROM sqlite_master 
      WHERE type='index' AND name NOT LIKE 'sqlite_%'
      ORDER BY name
    ''');
    return result.map((row) => row['name'] as String).toList();
  }

  /// Analyze query plan for a query
  Future<List<Map<String, dynamic>>> explainQueryPlan(String query, [List<dynamic>? args]) async {
    final db = await _dbService.database;
    return await db.rawQuery('EXPLAIN QUERY PLAN $query', args ?? []);
  }

  /// Optimize database (VACUUM and ANALYZE)
  Future<void> optimizeDatabase() async {
    final db = await _dbService.database;
    await db.execute('VACUUM');
    await db.execute('ANALYZE');
  }

  /// Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    final db = await _dbService.database;
    final stats = <String, dynamic>{};

    // Table sizes
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

    // Database page count (size indicator)
    final pageCount = await db.rawQuery('PRAGMA page_count');
    final pageSize = await db.rawQuery('PRAGMA page_size');
    final totalSize = (pageCount.first['page_count'] as int) *
        (pageSize.first['page_size'] as int);
    stats['database_size_bytes'] = totalSize;
    stats['database_size_mb'] = (totalSize / (1024 * 1024)).toStringAsFixed(2);

    return stats;
  }

  /// Check for orphaned records (foreign key violations)
  Future<List<String>> checkOrphanedRecords() async {
    final db = await _dbService.database;
    final issues = <String>[];

    // Check diet entries with invalid food_id
    final orphanedEntries = await db.rawQuery('''
      SELECT de.entry_id, de.food_id
      FROM tb_diet_entries de
      LEFT JOIN tb_food f ON de.food_id = f.food_id
      WHERE f.food_id IS NULL
    ''');

    if (orphanedEntries.isNotEmpty) {
      issues.add('Found ${orphanedEntries.length} diet entries with invalid food_id');
    }

    // Check health logs with invalid user_id
    final orphanedLogs = await db.rawQuery('''
      SELECT hl.log_id, hl.user_id
      FROM tb_health_log hl
      LEFT JOIN tb_user u ON hl.user_id = u.user_id
      WHERE u.user_id IS NULL
    ''');

    if (orphanedLogs.isNotEmpty) {
      issues.add('Found ${orphanedLogs.length} health logs with invalid user_id');
    }

    return issues;
  }

  /// Fix orphaned records
  Future<int> fixOrphanedRecords() async {
    final db = await _dbService.database;
    int fixed = 0;

    // Delete orphaned diet entries
    final deletedEntries = await db.rawDelete('''
      DELETE FROM tb_diet_entries
      WHERE food_id NOT IN (SELECT food_id FROM tb_food)
    ''');
    fixed += deletedEntries;

    // Delete orphaned health logs
    final deletedLogs = await db.rawDelete('''
      DELETE FROM tb_health_log
      WHERE user_id NOT IN (SELECT user_id FROM tb_user)
    ''');
    fixed += deletedLogs;

    return fixed;
  }

  /// Verify data integrity
  Future<DataIntegrityReport> verifyDataIntegrity() async {
    final db = await _dbService.database;
    final report = DataIntegrityReport();

    // Check foreign keys
    await db.execute('PRAGMA foreign_key_check');
    final fkViolations = await db.rawQuery('PRAGMA foreign_key_check');
    report.foreignKeyViolations = fkViolations.length;

    // Check for null required fields
    final nullDescriptions = await db.rawQuery('''
      SELECT COUNT(*) as count FROM tb_food WHERE food_description IS NULL
    ''');
    report.nullRequiredFields = nullDescriptions.first['count'] as int;

    // Check for invalid dates
    final invalidDates = await db.rawQuery('''
      SELECT COUNT(*) as count FROM tb_diet_entries 
      WHERE date NOT LIKE '____-__-__'
    ''');
    report.invalidDates = invalidDates.first['count'] as int;

    // Check orphaned records
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

