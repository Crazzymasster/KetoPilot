import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import '../drift_database_service.dart';
import '../drift_database.dart';
import '../models/food_portion_model.dart';

/// Food Portion DAO using Drift (works on all platforms including web)
class DriftFoodPortionDao {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  Future<AppDatabase> get _db async {
    try {
      return await _dbService.database;
    } catch (e) {
      debugPrint('[FOOD PORTION DAO] ❌ Error: $e');
      rethrow;
    }
  }

  /// Insert a new food portion
  Future<int> insertFoodPortion(FoodPortionModel portion) async {
    try {
      final db = await _db;
      final id = await db.into(db.foodPortions).insert(
        FoodPortionsCompanion(
          foodId: Value(portion.foodId),
          portionAmount: Value(portion.portionAmount),
          portionUnit: Value(portion.portionUnit),
          portionDescription: Value(portion.portionDescription),
          portionGramWeight: Value(portion.portionGramWeight),
          energyKcal: Value(portion.energyKcal),
          proteinG: Value(portion.proteinG),
          fatG: Value(portion.fatG),
          carbohydrateG: Value(portion.carbohydrateG),
          netCarbsG: Value(portion.netCarbsG),
          isDefault: Value(portion.isDefault),
        ),
      );
      return id;
    } catch (e) {
      debugPrint('[FOOD PORTION DAO] ❌ Insert error: $e');
      rethrow;
    }
  }

  /// Get portion by ID
  Future<FoodPortionModel?> getPortionById(int portionId) async {
    try {
      final db = await _db;
      final query = db.select(db.foodPortions)..where((p) => p.portionId.equals(portionId));
      final result = await query.getSingleOrNull();
      return result != null ? _portionFromDrift(result) : null;
    } catch (e) {
      debugPrint('[FOOD PORTION DAO] ❌ Get error: $e');
      rethrow;
    }
  }

  /// Get all portions for a food
  Future<List<FoodPortionModel>> getPortionsByFoodId(int foodId) async {
    try {
      final db = await _db;
      final results = await (db.select(db.foodPortions)
            ..where((p) => p.foodId.equals(foodId))
            ..orderBy([
              (p) => OrderingTerm(expression: p.isDefault, mode: OrderingMode.desc),
              (p) => OrderingTerm(expression: p.portionAmount),
            ]))
          .get();
      return results.map(_portionFromDrift).toList();
    } catch (e) {
      debugPrint('[FOOD PORTION DAO] ❌ Get by food ID error: $e');
      rethrow;
    }
  }

  /// Get default portion for a food
  Future<FoodPortionModel?> getDefaultPortion(int foodId) async {
    try {
      final db = await _db;
      final query = db.select(db.foodPortions)
        ..where((p) => p.foodId.equals(foodId) & p.isDefault.equals(1));
      final result = await query.getSingleOrNull();
      return result != null ? _portionFromDrift(result) : null;
    } catch (e) {
      debugPrint('[FOOD PORTION DAO] ❌ Get default portion error: $e');
      rethrow;
    }
  }

  FoodPortionModel _portionFromDrift(FoodPortion row) {
    return FoodPortionModel(
      portionId: row.portionId,
      foodId: row.foodId,
      portionAmount: row.portionAmount,
      portionUnit: row.portionUnit,
      portionDescription: row.portionDescription,
      portionGramWeight: row.portionGramWeight,
      energyKcal: row.energyKcal,
      proteinG: row.proteinG,
      fatG: row.fatG,
      carbohydrateG: row.carbohydrateG,
      netCarbsG: row.netCarbsG,
      isDefault: row.isDefault,
      createdAt: row.createdAt,
    );
  }
}

