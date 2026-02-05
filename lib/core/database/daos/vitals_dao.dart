import '../database_service.dart';
import '../models/vitals_model.dart';

/// Data Access Object for tb_vitals table
class VitalsDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new vitals entry
  Future<int> insertVitals(VitalsModel vitals) async {
    final db = await _dbService.database;
    return await db.insert('tb_vitals', vitals.toMap());
  }

  /// Get vitals by ID
  Future<VitalsModel?> getVitalsById(int vitalId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_vitals',
      where: 'vital_id = ?',
      whereArgs: [vitalId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return VitalsModel.fromMap(maps.first);
  }

  /// Get vitals for a user on a specific date
  Future<List<VitalsModel>> getVitalsByDate(int userId, String date) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_vitals',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => VitalsModel.fromMap(map)).toList();
  }

  /// Get vitals for a user within a date range
  Future<List<VitalsModel>> getVitalsByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_vitals',
      where: 'user_id = ? AND date >= ? AND date <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => VitalsModel.fromMap(map)).toList();
  }

  /// Update vitals
  Future<int> updateVitals(VitalsModel vitals) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_vitals',
      vitals.toMap(),
      where: 'vital_id = ?',
      whereArgs: [vitals.vitalId],
    );
  }

  /// Delete vitals
  Future<int> deleteVitals(int vitalId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_vitals',
      where: 'vital_id = ?',
      whereArgs: [vitalId],
    );
  }
}

