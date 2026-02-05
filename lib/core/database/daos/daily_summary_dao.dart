import '../database_service.dart';
import '../models/daily_summary_model.dart';

/// Data Access Object for tb_daily_summary table
class DailySummaryDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert or replace daily summary
  Future<int> upsertDailySummary(DailySummaryModel summary) async {
    final db = await _dbService.database;
    return await db.insert(
      'tb_daily_summary',
      summary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get daily summary for a specific date
  Future<DailySummaryModel?> getDailySummary(int userId, String date) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_daily_summary',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return DailySummaryModel.fromMap(maps.first);
  }

  /// Get daily summaries for a date range
  Future<List<DailySummaryModel>> getDailySummariesByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_daily_summary',
      where: 'user_id = ? AND date >= ? AND date <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'date ASC',
    );
    return maps.map((map) => DailySummaryModel.fromMap(map)).toList();
  }

  /// Update daily summary
  Future<int> updateDailySummary(DailySummaryModel summary) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_daily_summary',
      summary.toMap(),
      where: 'summary_id = ?',
      whereArgs: [summary.summaryId],
    );
  }

  /// Delete daily summary
  Future<int> deleteDailySummary(int summaryId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_daily_summary',
      where: 'summary_id = ?',
      whereArgs: [summaryId],
    );
  }

  /// Get unsynced daily summaries
  Future<List<DailySummaryModel>> getUnsyncedDailySummaries(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_daily_summary',
      where: 'user_id = ? AND synced = 0',
      whereArgs: [userId],
      orderBy: 'date ASC',
    );
    return maps.map((map) => DailySummaryModel.fromMap(map)).toList();
  }
}

