import '../database_service.dart';
import '../models/medication_log_model.dart';

/// Data Access Object for tb_medication_logs table
class MedicationLogDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new medication log
  Future<int> insertMedicationLog(MedicationLogModel log) async {
    final db = await _dbService.database;
    return await db.insert('tb_medication_logs', log.toMap());
  }

  /// Get medication log by ID
  Future<MedicationLogModel?> getMedicationLogById(int logId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_medication_logs',
      where: 'log_id = ?',
      whereArgs: [logId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return MedicationLogModel.fromMap(maps.first);
  }

  /// Get logs for a medication
  Future<List<MedicationLogModel>> getLogsByMedicationId(int medicationId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_medication_logs',
      where: 'medication_id = ?',
      whereArgs: [medicationId],
      orderBy: 'scheduled_at DESC',
    );
    return maps.map((map) => MedicationLogModel.fromMap(map)).toList();
  }

  /// Get logs for a user within a date range
  Future<List<MedicationLogModel>> getLogsByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_medication_logs',
      where: 'user_id = ? AND scheduled_at >= ? AND scheduled_at <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'scheduled_at ASC',
    );
    return maps.map((map) => MedicationLogModel.fromMap(map)).toList();
  }

  /// Mark medication as taken
  Future<int> markAsTaken(int logId, DateTime takenAt) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_medication_logs',
      {
        'taken': 1,
        'taken_at': takenAt.toIso8601String(),
      },
      where: 'log_id = ?',
      whereArgs: [logId],
    );
  }

  /// Mark medication as skipped
  Future<int> markAsSkipped(int logId, String reason) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_medication_logs',
      {
        'taken': 0,
        'skipped_reason': reason,
      },
      where: 'log_id = ?',
      whereArgs: [logId],
    );
  }

  /// Get adherence rate for a medication
  Future<double> getAdherenceRate(int medicationId, String startDate, String endDate) async {
    final db = await _dbService.database;
    final result = await db.rawQuery('''
      SELECT 
        COUNT(*) as total,
        SUM(taken) as taken_count
      FROM tb_medication_logs
      WHERE medication_id = ? AND scheduled_at >= ? AND scheduled_at <= ?
    ''', [medicationId, startDate, endDate]);

    if (result.isEmpty) return 0.0;
    final total = result.first['total'] as int? ?? 0;
    final taken = result.first['taken_count'] as int? ?? 0;
    if (total == 0) return 0.0;
    return taken / total;
  }

  /// Update medication log
  Future<int> updateMedicationLog(MedicationLogModel log) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_medication_logs',
      log.toMap(),
      where: 'log_id = ?',
      whereArgs: [log.logId],
    );
  }

  /// Delete medication log
  Future<int> deleteMedicationLog(int logId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_medication_logs',
      where: 'log_id = ?',
      whereArgs: [logId],
    );
  }
}

