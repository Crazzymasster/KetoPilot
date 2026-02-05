import '../database_service.dart';
import '../models/symptoms_model.dart';

/// Data Access Object for tb_symptoms table
class SymptomsDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new symptoms entry
  Future<int> insertSymptoms(SymptomsModel symptoms) async {
    final db = await _dbService.database;
    return await db.insert('tb_symptoms', symptoms.toMap());
  }

  /// Get symptoms by ID
  Future<SymptomsModel?> getSymptomsById(int symptomId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_symptoms',
      where: 'symptom_id = ?',
      whereArgs: [symptomId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return SymptomsModel.fromMap(maps.first);
  }

  /// Get symptoms for a user on a specific date
  Future<List<SymptomsModel>> getSymptomsByDate(int userId, String date) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_symptoms',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => SymptomsModel.fromMap(map)).toList();
  }

  /// Get symptoms for a user within a date range
  Future<List<SymptomsModel>> getSymptomsByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_symptoms',
      where: 'user_id = ? AND date >= ? AND date <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => SymptomsModel.fromMap(map)).toList();
  }

  /// Update symptoms
  Future<int> updateSymptoms(SymptomsModel symptoms) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_symptoms',
      symptoms.toMap(),
      where: 'symptom_id = ?',
      whereArgs: [symptoms.symptomId],
    );
  }

  /// Delete symptoms
  Future<int> deleteSymptoms(int symptomId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_symptoms',
      where: 'symptom_id = ?',
      whereArgs: [symptomId],
    );
  }
}

