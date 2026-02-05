import '../database_service.dart';
import '../models/user_model.dart';

/// Data Access Object for tb_user table
class UserDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new user
  Future<int> insertUser(UserModel user) async {
    final db = await _dbService.database;
    return await db.insert('tb_user', user.toMap());
  }

  /// Get user by ID
  Future<UserModel?> getUserById(int userId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_user',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_user',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// Get user by anonymous ID
  Future<UserModel?> getUserByAnonymousId(String anonymousId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_user',
      where: 'anonymous_id = ?',
      whereArgs: [anonymousId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// Update user
  Future<int> updateUser(UserModel user) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_user',
      user.toMap(),
      where: 'user_id = ?',
      whereArgs: [user.userId],
    );
  }

  /// Delete user
  Future<int> deleteUser(int userId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_user',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  /// Update last login timestamp
  Future<int> updateLastLogin(int userId, DateTime loginTime) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_user',
      {
        'last_login': loginTime.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  /// Check if email exists
  Future<bool> emailExists(String email) async {
    final db = await _dbService.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM tb_user WHERE email = ?',
      [email],
    );
    return (result.first['count'] as int) > 0;
  }
}

