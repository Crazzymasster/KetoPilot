import 'package:sqflite/sqflite.dart';
import '../database_service.dart';
// Note: This DAO uses sqflite (mobile only). For web support, use Drift-based DAOs.
import '../models/diet_entry_model.dart';

/// Data Access Object for tb_diet_entries table
class DietEntryDao {
  final DatabaseService? _dbService;
  final Database? _testDatabase;

  /// Constructor for production use
  DietEntryDao() : _dbService = DatabaseService(), _testDatabase = null;

  /// Constructor for testing with a provided database
  DietEntryDao.withDatabase(Database database)
      : _dbService = null,
        _testDatabase = database;

  Future<Database> get _database async {
    if (_testDatabase != null) return _testDatabase!;
    return await _dbService?.database ?? (throw StateError('Database service not initialized'));
  }

  /// Insert a new diet entry
  Future<int> insertDietEntry(DietEntryModel entry) async {
    final db = await _database;
    return await db.insert('tb_diet_entries', entry.toMap());
  }

  /// Get diet entry by ID
  Future<DietEntryModel?> getDietEntryById(int entryId) async {
    final db = await _database;
    final maps = await db.query(
      'tb_diet_entries',
      where: 'entry_id = ?',
      whereArgs: [entryId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return DietEntryModel.fromMap(maps.first);
  }

  /// Get all diet entries for a user on a specific date
  Future<List<DietEntryModel>> getDietEntriesByDate(
    int userId,
    String date,
  ) async {
    final db = await _database;
    final maps = await db.query(
      'tb_diet_entries',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => DietEntryModel.fromMap(map)).toList();
  }

  /// Get diet entries for a user within a date range
  Future<List<DietEntryModel>> getDietEntriesByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    final db = await _database;
    final maps = await db.query(
      'tb_diet_entries',
      where: 'user_id = ? AND date >= ? AND date <= ?',
      whereArgs: [userId, startDate, endDate],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => DietEntryModel.fromMap(map)).toList();
  }

  /// Get unsynced diet entries
  Future<List<DietEntryModel>> getUnsyncedDietEntries(int userId) async {
    final db = await _database;
    final maps = await db.query(
      'tb_diet_entries',
      where: 'user_id = ? AND synced = 0',
      whereArgs: [userId],
      orderBy: 'recorded_at ASC',
    );
    return maps.map((map) => DietEntryModel.fromMap(map)).toList();
  }

  /// Update diet entry
  Future<int> updateDietEntry(DietEntryModel entry) async {
    final db = await _database;
    return await db.update(
      'tb_diet_entries',
      entry.toMap(),
      where: 'entry_id = ?',
      whereArgs: [entry.entryId],
    );
  }

  /// Delete diet entry
  Future<int> deleteDietEntry(int entryId) async {
    final db = await _database;
    return await db.delete(
      'tb_diet_entries',
      where: 'entry_id = ?',
      whereArgs: [entryId],
    );
  }

  /// Mark entries as synced
  Future<int> markAsSynced(List<int> entryIds) async {
    if (entryIds.isEmpty) return 0;
    final db = await _database;
    final placeholders = entryIds.map((_) => '?').join(',');
    return await db.rawUpdate(
      'UPDATE tb_diet_entries SET synced = 1 WHERE entry_id IN ($placeholders)',
      entryIds,
    );
  }

  /// Get daily totals for a user on a specific date
  Future<Map<String, double>> getDailyTotals(int userId, String date) async {
    final db = await _database;
    final result = await db.rawQuery('''
      SELECT 
        COALESCE(SUM(total_energy_kcal), 0) as total_energy_kcal,
        COALESCE(SUM(total_protein_g), 0) as total_protein_g,
        COALESCE(SUM(total_fat_g), 0) as total_fat_g,
        COALESCE(SUM(total_carbohydrate_g), 0) as total_carbohydrate_g,
        COALESCE(SUM(total_net_carbs_g), 0) as total_net_carbs_g,
        COALESCE(SUM(total_fiber_g), 0) as total_fiber_g,
        COALESCE(SUM(total_sodium_mg), 0) as total_sodium_mg
      FROM tb_diet_entries
      WHERE user_id = ? AND date = ?
    ''', [userId, date]);

    if (result.isEmpty) {
      return {
        'total_energy_kcal': 0.0,
        'total_protein_g': 0.0,
        'total_fat_g': 0.0,
        'total_carbohydrate_g': 0.0,
        'total_net_carbs_g': 0.0,
        'total_fiber_g': 0.0,
        'total_sodium_mg': 0.0,
      };
    }

    return {
      'total_energy_kcal': (result.first['total_energy_kcal'] as num).toDouble(),
      'total_protein_g': (result.first['total_protein_g'] as num).toDouble(),
      'total_fat_g': (result.first['total_fat_g'] as num).toDouble(),
      'total_carbohydrate_g': (result.first['total_carbohydrate_g'] as num).toDouble(),
      'total_net_carbs_g': (result.first['total_net_carbs_g'] as num).toDouble(),
      'total_fiber_g': (result.first['total_fiber_g'] as num).toDouble(),
      'total_sodium_mg': (result.first['total_sodium_mg'] as num).toDouble(),
    };
  }
}

