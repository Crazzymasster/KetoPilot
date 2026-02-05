import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import '../drift_database_service.dart';
import '../drift_database.dart';
import '../models/food_model.dart';

/// Food DAO using Drift (works on all platforms including web)
class DriftFoodDao {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  Future<AppDatabase> get _db async {
    try {
      return await _dbService.database;
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Error: $e');
      rethrow;
    }
  }

  /// Insert a new food
  Future<int> insertFood(FoodModel food) async {
    try {
      final db = await _db;
      final id = await db.into(db.foods).insert(
        FoodsCompanion(
          keylist: Value(food.keylist),
          foodDescription: Value(food.foodDescription),
          source: Value(food.source),
          createdByUserId: Value(food.createdByUserId),
          isVerified: Value(food.isVerified),
          isKetoFriendly: Value(food.isKetoFriendly),
          energyKcal: Value(food.energyKcal),
          totalProteinG: Value(food.totalProteinG),
          totalFatG: Value(food.totalFatG),
          totalCarbohydrateG: Value(food.totalCarbohydrateG),
          dietaryFiberG: Value(food.dietaryFiberG),
          sugarG: Value(food.sugarG),
          addedSugarG: Value(food.addedSugarG),
          netCarbsG: Value(food.netCarbsG),
          saturatedFatG: Value(food.saturatedFatG),
          monounsaturatedFatG: Value(food.monounsaturatedFatG),
          polyunsaturatedFatG: Value(food.polyunsaturatedFatG),
          transFatG: Value(food.transFatG),
          cholesterolMg: Value(food.cholesterolMg),
          sodiumMg: Value(food.sodiumMg),
          potassiumMg: Value(food.potassiumMg),
          magnesiumMg: Value(food.magnesiumMg),
          calciumMg: Value(food.calciumMg),
          glycemicIndex: Value(food.glycemicIndex),
          glycemicLoad: Value(food.glycemicLoad),
          vitamins: Value(food.vitamins),
          minerals: Value(food.minerals),
          foodPhotoUrl: Value(food.foodPhotoUrl),
        barcode: Value(food.barcode),
      ),
      );
      return id;
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Insert error: $e');
      rethrow;
    }
  }

  /// Get food by ID
  Future<FoodModel?> getFoodById(int foodId) async {
    try {
      final db = await _db;
      final query = db.select(db.foods)..where((f) => f.foodId.equals(foodId));
      final result = await query.getSingleOrNull();
      return result != null ? _foodFromDrift(result) : null;
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Get error: $e');
      rethrow;
    }
  }

  /// Search foods by description (case-insensitive)
  Future<List<FoodModel>> searchFoods(String query, {int limit = 20}) async {
    try {
      final db = await _db;
      final searchTerm = '%${query.toLowerCase()}%';
      final results = await (db.select(db.foods)
            ..where((f) => f.foodDescription.lower().like(searchTerm))
            ..limit(limit))
          .get();
      return results.map(_foodFromDrift).toList();
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Search error: $e');
      rethrow;
    }
  }

  /// Get keto-friendly foods
  Future<List<FoodModel>> getKetoFriendlyFoods({int limit = 50}) async {
    final db = await _db;
    final results = await (db.select(db.foods)
          ..where((f) => f.isKetoFriendly.equals(1))
          ..limit(limit))
        .get();
    return results.map(_foodFromDrift).toList();
  }

  /// Convert Drift Food row to FoodModel
  FoodModel _foodFromDrift(Food row) {
    return FoodModel(
      foodId: row.foodId,
      keylist: row.keylist,
      foodDescription: row.foodDescription,
      source: row.source,
      createdByUserId: row.createdByUserId,
      isVerified: row.isVerified,
      isKetoFriendly: row.isKetoFriendly,
      energyKcal: row.energyKcal,
      totalProteinG: row.totalProteinG,
      totalFatG: row.totalFatG,
      totalCarbohydrateG: row.totalCarbohydrateG,
      dietaryFiberG: row.dietaryFiberG,
      sugarG: row.sugarG,
      addedSugarG: row.addedSugarG,
      netCarbsG: row.netCarbsG,
      saturatedFatG: row.saturatedFatG,
      monounsaturatedFatG: row.monounsaturatedFatG,
      polyunsaturatedFatG: row.polyunsaturatedFatG,
      transFatG: row.transFatG,
      cholesterolMg: row.cholesterolMg,
      sodiumMg: row.sodiumMg,
      potassiumMg: row.potassiumMg,
      magnesiumMg: row.magnesiumMg,
      calciumMg: row.calciumMg,
      glycemicIndex: row.glycemicIndex,
      glycemicLoad: row.glycemicLoad,
      vitamins: row.vitamins,
      minerals: row.minerals,
      foodPhotoUrl: row.foodPhotoUrl,
      barcode: row.barcode,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  /// Get total count of foods in the database
  Future<int> getFoodsCount() async {
    try {
      final db = await _db;
      final query = db.selectOnly(db.foods)..addColumns([db.foods.foodId.count()]);
      final result = await query.getSingle();
      return result.read(db.foods.foodId.count()) ?? 0;
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Count error: $e');
      return 0;
    }
  }

  /// Get all foods with optional limit
  Future<List<FoodModel>> getAllFoods({int? limit}) async {
    try {
      final db = await _db;
      final query = db.select(db.foods);
      if (limit != null) {
        query.limit(limit);
      }
      final results = await query.get();
      return results.map(_foodFromDrift).toList();
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Get all error: $e');
      rethrow;
    }
  }

  /// Insert multiple foods at once (for seeding)
  Future<void> insertFoods(List<FoodModel> foods) async {
    try {
      final db = await _db;
      await db.batch((batch) {
        for (final food in foods) {
          batch.insert(
            db.foods,
            FoodsCompanion(
              keylist: Value(food.keylist),
              foodDescription: Value(food.foodDescription),
              source: Value(food.source),
              createdByUserId: Value(food.createdByUserId),
              isVerified: Value(food.isVerified),
              isKetoFriendly: Value(food.isKetoFriendly),
              energyKcal: Value(food.energyKcal),
              totalProteinG: Value(food.totalProteinG),
              totalFatG: Value(food.totalFatG),
              totalCarbohydrateG: Value(food.totalCarbohydrateG),
              dietaryFiberG: Value(food.dietaryFiberG),
              sugarG: Value(food.sugarG),
              addedSugarG: Value(food.addedSugarG),
              netCarbsG: Value(food.netCarbsG),
              saturatedFatG: Value(food.saturatedFatG),
              monounsaturatedFatG: Value(food.monounsaturatedFatG),
              polyunsaturatedFatG: Value(food.polyunsaturatedFatG),
              transFatG: Value(food.transFatG),
              cholesterolMg: Value(food.cholesterolMg),
              sodiumMg: Value(food.sodiumMg),
              potassiumMg: Value(food.potassiumMg),
              magnesiumMg: Value(food.magnesiumMg),
              calciumMg: Value(food.calciumMg),
              glycemicIndex: Value(food.glycemicIndex),
              glycemicLoad: Value(food.glycemicLoad),
              vitamins: Value(food.vitamins),
              minerals: Value(food.minerals),
              foodPhotoUrl: Value(food.foodPhotoUrl),
              barcode: Value(food.barcode),
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      });
      debugPrint('[FOOD DAO] ✅ Inserted ${foods.length} foods');
    } catch (e) {
      debugPrint('[FOOD DAO] ❌ Batch insert error: $e');
      rethrow;
    }
  }
}



