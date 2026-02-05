import 'package:sqflite/sqflite.dart';
import '../database_service.dart';
import '../models/food_model.dart';

/// Data Access Object for tb_food table
class FoodDao {
  final DatabaseService? _dbService;
  final Database? _testDatabase;

  /// Constructor for production use
  FoodDao() : _dbService = DatabaseService(), _testDatabase = null;

  /// Constructor for testing with a provided database
  FoodDao.withDatabase(Database database)
      : _dbService = null,
        _testDatabase = database;

  Future<Database> get _database async {
    if (_testDatabase != null) return _testDatabase!;
    return await _dbService?.database ?? (throw StateError('Database service not initialized'));
  }

  /// Insert a new food
  Future<int> insertFood(FoodModel food) async {
    final db = await _database;
    return await db.insert('tb_food', food.toMap());
  }

  /// Get food by ID
  Future<FoodModel?> getFoodById(int foodId) async {
    final db = await _database;
    final maps = await db.query(
      'tb_food',
      where: 'food_id = ?',
      whereArgs: [foodId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FoodModel.fromMap(maps.first);
  }

  /// Get food by keylist
  Future<FoodModel?> getFoodByKeylist(String keylist) async {
    final db = await _database;
    final maps = await db.query(
      'tb_food',
      where: 'keylist = ?',
      whereArgs: [keylist],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FoodModel.fromMap(maps.first);
  }

  /// Get food by barcode
  Future<FoodModel?> getFoodByBarcode(String barcode) async {
    final db = await _database;
    final maps = await db.query(
      'tb_food',
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FoodModel.fromMap(maps.first);
  }

  /// Search foods by description (using LIKE for now, FTS5 would be better)
  Future<List<FoodModel>> searchFoods(String query, {int limit = 20}) async {
    final db = await _database;
    final maps = await db.query(
      'tb_food',
      where: 'LOWER(food_description) LIKE ?',
      whereArgs: ['%${query.toLowerCase()}%'],
      limit: limit,
    );
    return maps.map((map) => FoodModel.fromMap(map)).toList();
  }

  /// Get keto-friendly foods
  Future<List<FoodModel>> getKetoFriendlyFoods({int limit = 50}) async {
    final db = await _database;
    final maps = await db.query(
      'tb_food',
      where: 'is_keto_friendly = 1',
      limit: limit,
    );
    return maps.map((map) => FoodModel.fromMap(map)).toList();
  }

  /// Get foods by net carbs range
  Future<List<FoodModel>> getFoodsByNetCarbs({
    double? maxNetCarbs,
    int limit = 50,
  }) async {
    final db = await _database;
    String whereClause = 'net_carbs_g IS NOT NULL';
    List<dynamic> whereArgs = [];

    if (maxNetCarbs != null) {
      whereClause += ' AND net_carbs_g <= ?';
      whereArgs.add(maxNetCarbs);
    }

    final maps = await db.query(
      'tb_food',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'net_carbs_g ASC',
      limit: limit,
    );
    return maps.map((map) => FoodModel.fromMap(map)).toList();
  }

  /// Update food
  Future<int> updateFood(FoodModel food) async {
    final db = await _database;
    return await db.update(
      'tb_food',
      food.toMap(),
      where: 'food_id = ?',
      whereArgs: [food.foodId],
    );
  }

  /// Delete food
  Future<int> deleteFood(int foodId) async {
    final db = await _database;
    return await db.delete(
      'tb_food',
      where: 'food_id = ?',
      whereArgs: [foodId],
    );
  }
}

