import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart' hide isNotNull;
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/drift.dart' as drift;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:metabolicapp/core/database/drift_database.dart';
import 'package:metabolicapp/core/database/models/food_model.dart';
import 'package:metabolicapp/core/database/daos/drift_food_dao.dart';

void main() {
  group('Drift Database Tests', () {
    late AppDatabase database;
    late _TestDriftFoodDao foodDao;

    setUpAll(() {
      // Initialize FFI for testing
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      // Use in-memory database for testing
      database = AppDatabase(NativeDatabase.memory());
      // Create a custom DAO that uses our test database
      foodDao = _TestDriftFoodDao(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('Database initializes successfully', () async {
      expect(database, isNotNull);
      expect(database, isA<AppDatabase>());
    });

    test('Can insert food into database', () async {
      final food = FoodModel(
        foodDescription: 'Test Avocado',
        energyKcal: 160.0,
        totalProteinG: 2.0,
        totalFatG: 15.0,
        totalCarbohydrateG: 9.0,
        dietaryFiberG: 7.0,
        netCarbsG: 2.0,
        source: 'test',
      );

      final id = await foodDao.insertFood(food);
      expect(id, greaterThan(0));
    });

    test('Can retrieve food by ID', () async {
      // Insert a food first
      final food = FoodModel(
        foodDescription: 'Test Food for Retrieval',
        energyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
        source: 'test',
      );

      final id = await foodDao.insertFood(food);
      expect(id, greaterThan(0));

      // Retrieve it
      final retrieved = await foodDao.getFoodById(id);
      expect(retrieved, isNotNull);
      expect(retrieved?.foodId, equals(id));
      expect(retrieved?.foodDescription, equals('Test Food for Retrieval'));
      expect(retrieved?.energyKcal, equals(100.0));
    });

    test('Can search foods by description', () async {
      // Insert test foods
      await foodDao.insertFood(FoodModel(
        foodDescription: 'Avocado Toast',
        energyKcal: 200.0,
        totalProteinG: 5.0,
        totalFatG: 10.0,
        totalCarbohydrateG: 20.0,
        source: 'test',
      ));

      await foodDao.insertFood(FoodModel(
        foodDescription: 'Avocado Salad',
        energyKcal: 150.0,
        totalProteinG: 3.0,
        totalFatG: 12.0,
        totalCarbohydrateG: 8.0,
        source: 'test',
      ));

      await foodDao.insertFood(FoodModel(
        foodDescription: 'Chicken Breast',
        energyKcal: 165.0,
        totalProteinG: 31.0,
        totalFatG: 3.6,
        totalCarbohydrateG: 0.0,
        source: 'test',
      ));

      // Search for avocado
      final results = await foodDao.searchFoods('avocado');
      expect(results.length, equals(2));
      expect(results.any((f) => f.foodDescription.contains('Toast')), isTrue);
      expect(results.any((f) => f.foodDescription.contains('Salad')), isTrue);
    });

    test('Can insert and retrieve multiple foods', () async {
      final foods = [
        FoodModel(
          foodDescription: 'Food 1',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          source: 'test',
        ),
        FoodModel(
          foodDescription: 'Food 2',
          energyKcal: 200.0,
          totalProteinG: 20.0,
          totalFatG: 10.0,
          totalCarbohydrateG: 10.0,
          source: 'test',
        ),
        FoodModel(
          foodDescription: 'Food 3',
          energyKcal: 300.0,
          totalProteinG: 30.0,
          totalFatG: 15.0,
          totalCarbohydrateG: 15.0,
          source: 'test',
        ),
      ];

      // Insert all foods
      final ids = <int>[];
      for (final food in foods) {
        final id = await foodDao.insertFood(food);
        ids.add(id);
        expect(id, greaterThan(0));
      }

      // Retrieve all foods
      for (int i = 0; i < ids.length; i++) {
        final retrieved = await foodDao.getFoodById(ids[i]);
        expect(retrieved, isNotNull);
        expect(retrieved?.foodDescription, equals(foods[i].foodDescription));
      }
    });

    test('Database operations are transactional', () async {
      // Start a transaction
      await database.transaction(() async {
        await foodDao.insertFood(FoodModel(
          foodDescription: 'Transaction Food 1',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          source: 'test',
        ));

        await foodDao.insertFood(FoodModel(
          foodDescription: 'Transaction Food 2',
          energyKcal: 200.0,
          totalProteinG: 20.0,
          totalFatG: 10.0,
          totalCarbohydrateG: 10.0,
          source: 'test',
        ));
      });

      // Both foods should be in the database
      final results = await foodDao.searchFoods('Transaction');
      expect(results.length, equals(2));
    });
  });
}

/// Test DAO that uses a provided database instance
class _TestDriftFoodDao {
  final AppDatabase _db;

  _TestDriftFoodDao(this._db);

  Future<AppDatabase> get _database async => _db;

  /// Insert a new food
  Future<int> insertFood(FoodModel food) async {
    final db = await _database;
    return await db.into(db.foods).insert(
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
  }

  /// Get food by ID
  Future<FoodModel?> getFoodById(int foodId) async {
    final db = await _database;
    final query = db.select(db.foods)..where((f) => f.foodId.equals(foodId));
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return _foodFromDrift(result);
  }

  /// Search foods by description (case-insensitive)
  Future<List<FoodModel>> searchFoods(String query, {int limit = 20}) async {
    final db = await _database;
    final searchTerm = '%${query.toLowerCase()}%';
    final results = await (db.select(db.foods)
          ..where((f) => f.foodDescription.lower().like(searchTerm))
          ..limit(limit))
        .get();
    return results.map(_foodFromDrift).toList();
  }

  /// Get keto-friendly foods
  Future<List<FoodModel>> getKetoFriendlyFoods({int limit = 50}) async {
    final db = await _database;
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
}

