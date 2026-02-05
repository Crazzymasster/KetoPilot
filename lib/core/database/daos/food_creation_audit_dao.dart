import '../database_service.dart';
import '../models/food_creation_audit_model.dart';

/// Data Access Object for tb_food_creation_audit table
class FoodCreationAuditDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert audit record
  Future<int> insertAudit(FoodCreationAuditModel audit) async {
    final db = await _dbService.database;
    return await db.insert('tb_food_creation_audit', audit.toMap());
  }

  /// Get audit by ID
  Future<FoodCreationAuditModel?> getAuditById(int auditId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_food_creation_audit',
      where: 'audit_id = ?',
      whereArgs: [auditId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FoodCreationAuditModel.fromMap(maps.first);
  }

  /// Get audit records for a user within a date range
  Future<List<FoodCreationAuditModel>> getAuditsByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_food_creation_audit',
      where: 'user_id = ? AND created_at >= ? AND created_at <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => FoodCreationAuditModel.fromMap(map)).toList();
  }

  /// Get flagged audit records
  Future<List<FoodCreationAuditModel>> getFlaggedAudits(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_food_creation_audit',
      where: 'user_id = ? AND is_flagged = 1',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => FoodCreationAuditModel.fromMap(map)).toList();
  }

  /// Count food creations in a time window
  Future<int> countFoodCreationsInWindow(
    int userId,
    String windowStart,
    String windowEnd,
  ) async {
    final db = await _dbService.database;
    final result = await db.rawQuery('''
      SELECT COUNT(*) as count
      FROM tb_food_creation_audit
      WHERE user_id = ? AND created_at >= ? AND created_at <= ?
    ''', [userId, windowStart, windowEnd]);

    return result.first['count'] as int? ?? 0;
  }

  /// Flag an audit record
  Future<int> flagAudit(int auditId, String reason) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_food_creation_audit',
      {
        'is_flagged': 1,
        'flag_reason': reason,
      },
      where: 'audit_id = ?',
      whereArgs: [auditId],
    );
  }

  /// Delete audit record
  Future<int> deleteAudit(int auditId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_food_creation_audit',
      where: 'audit_id = ?',
      whereArgs: [auditId],
    );
  }
}

