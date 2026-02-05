import '../database_service.dart';
import '../models/medication_model.dart';

/// Data Access Object for tb_medications table
class MedicationDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new medication
  Future<int> insertMedication(MedicationModel medication) async {
    final db = await _dbService.database;
    return await db.insert('tb_medications', medication.toMap());
  }

  /// Get medication by ID
  Future<MedicationModel?> getMedicationById(int medicationId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_medications',
      where: 'medication_id = ?',
      whereArgs: [medicationId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return MedicationModel.fromMap(maps.first);
  }

  /// Get all medications for a user
  Future<List<MedicationModel>> getMedicationsByUserId(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_medications',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'start_date DESC',
    );
    return maps.map((map) => MedicationModel.fromMap(map)).toList();
  }

  /// Get active medications (no end_date or end_date in future)
  Future<List<MedicationModel>> getActiveMedications(int userId) async {
    final db = await _dbService.database;
    final now = DateTime.now().toIso8601String();
    final maps = await db.query(
      'tb_medications',
      where: 'user_id = ? AND (end_date IS NULL OR end_date >= ?)',
      whereArgs: [userId, now],
      orderBy: 'start_date DESC',
    );
    return maps.map((map) => MedicationModel.fromMap(map)).toList();
  }

  /// Update medication
  Future<int> updateMedication(MedicationModel medication) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_medications',
      medication.toMap(),
      where: 'medication_id = ?',
      whereArgs: [medication.medicationId],
    );
  }

  /// Delete medication
  Future<int> deleteMedication(int medicationId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_medications',
      where: 'medication_id = ?',
      whereArgs: [medicationId],
    );
  }
}

