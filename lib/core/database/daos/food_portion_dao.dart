import '../database_service.dart';
import '../models/food_portion_model.dart';

/// Data Access Object for tb_food_portions table
class FoodPortionDao {
  final DatabaseService _dbService = DatabaseService();

  /// Insert a new food portion
  Future<int> insertFoodPortion(FoodPortionModel portion) async {
    final db = await _dbService.database;
    return await db.insert('tb_food_portions', portion.toMap());
  }

  /// Get portion by ID
  Future<FoodPortionModel?> getPortionById(int portionId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_food_portions',
      where: 'portion_id = ?',
      whereArgs: [portionId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FoodPortionModel.fromMap(maps.first);
  }

  /// Get all portions for a food
  Future<List<FoodPortionModel>> getPortionsByFoodId(int foodId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_food_portions',
      where: 'food_id = ?',
      whereArgs: [foodId],
      orderBy: 'is_default DESC, portion_amount ASC',
    );
    return maps.map((map) => FoodPortionModel.fromMap(map)).toList();
  }

  /// Get default portion for a food
  Future<FoodPortionModel?> getDefaultPortion(int foodId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'tb_food_portions',
      where: 'food_id = ? AND is_default = 1',
      whereArgs: [foodId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FoodPortionModel.fromMap(maps.first);
  }

  /// Update food portion
  Future<int> updateFoodPortion(FoodPortionModel portion) async {
    final db = await _dbService.database;
    return await db.update(
      'tb_food_portions',
      portion.toMap(),
      where: 'portion_id = ?',
      whereArgs: [portion.portionId],
    );
  }

  /// Delete food portion
  Future<int> deleteFoodPortion(int portionId) async {
    final db = await _dbService.database;
    return await db.delete(
      'tb_food_portions',
      where: 'portion_id = ?',
      whereArgs: [portionId],
    );
  }
}

