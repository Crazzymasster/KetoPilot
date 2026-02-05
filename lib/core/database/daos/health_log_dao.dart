import '../database_service.dart';
import '../models/health_log_model.dart';

/// Data Access Object for tb_health_log table
class HealthLogDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new health log entry
  Future<int> insertHealthLog(HealthLogModel log) async {
    final db = await _dbService.database;
    return await db.insert('tb_health_log', log.toMap());
  }

  /// Get health log by ID
  Future<HealthLogModel?> getHealthLogById(int logId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_health_log',
      where: 'log_id = ?',
      whereArgs: [logId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return HealthLogModel.fromMap(maps.first);
  }

  /// Get all health logs for a user on a specific date
  Future<List<HealthLogModel>> getHealthLogsByDate(
    int userId,
    String date,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_health_log',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => HealthLogModel.fromMap(map)).toList();
  }

  /// Get health logs for a user within a date range
  Future<List<HealthLogModel>> getHealthLogsByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_health_log',
      where: 'user_id = ? AND date >= ? AND date <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => HealthLogModel.fromMap(map)).toList();
  }

  /// Get latest GKI score for a user
  Future<HealthLogModel?> getLatestGki(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_health_log',
      where: 'user_id = ? AND gki_score IS NOT NULL',
      whereArgs: [userId],
      orderBy: 'recorded_at DESC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return HealthLogModel.fromMap(maps.first);
  }

  /// Get average GKI for a date range
  Future<double?> getAverageGki(int userId, String startDate, String endDate) async {
    final db = await _dbService.database;
    final result = await db.rawQuery('''
      SELECT AVG(gki_score) as avg_gki
      FROM tb_health_log
      WHERE user_id = ? AND date >= ? AND date <= ? AND gki_score IS NOT NULL
    ''', [userId, startDate, endDate]);

    if (result.isEmpty || result.first['avg_gki'] == null) {
      return null;
    }
    return (result.first['avg_gki'] as num).toDouble();
  }

  /// Update health log
  Future<int> updateHealthLog(HealthLogModel log) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_health_log',
      log.toMap(),
      where: 'log_id = ?',
      whereArgs: [log.logId],
    );
  }

  /// Delete health log
  Future<int> deleteHealthLog(int logId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_health_log',
      where: 'log_id = ?',
      whereArgs: [logId],
    );
  }

  /// Get unsynced health logs
  Future<List<HealthLogModel>> getUnsyncedHealthLogs(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_health_log',
      where: 'user_id = ? AND synced = 0',
      whereArgs: [userId],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => HealthLogModel.fromMap(map)).toList();
  }

  /// Mark logs as synced
  Future<int> markAsSynced(List<int> logIds) async {
    if (logIds.isEmpty) return 0;
    final db = await _dbService.database;
    final placeholders = logIds.map((_) => '?').join(',');
    return await db.rawUpdate(
      'UPDATE tb_health_log SET synced = 1 WHERE log_id IN ($placeholders)',
      logIds,
    );
  }
}

