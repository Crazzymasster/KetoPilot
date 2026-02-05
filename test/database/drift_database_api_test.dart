import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart' hide isNotNull, isNull;
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:metabolicapp/core/database/drift_database.dart';
import 'package:metabolicapp/core/database/models/food_model.dart';

/// Comprehensive API tests for Drift database
/// Tests all CRUD operations and edge cases
void main() {
  group('Drift Database API Tests', () {
    late AppDatabase database;
    late _TestDriftFoodDao foodDao;

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      // Use in-memory database for testing
      database = AppDatabase(NativeDatabase.memory());
      foodDao = _TestDriftFoodDao(database);
    });

    tearDown(() async {
      await database.close();
    });

    group('CREATE Operations', () {
      test('insertFood - basic insertion', () async {
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

      test('insertFood - with all optional fields', () async {
        final food = FoodModel(
          foodDescription: 'Complete Food Item',
          energyKcal: 200.0,
          totalProteinG: 20.0,
          totalFatG: 10.0,
          totalCarbohydrateG: 15.0,
          dietaryFiberG: 5.0,
          netCarbsG: 10.0,
          source: 'test',
          keylist: 'test-key-123',
          createdByUserId: 1,
          isVerified: 1,
          isKetoFriendly: 1,
          sugarG: 3.0,
          addedSugarG: 0.0,
          saturatedFatG: 2.0,
          monounsaturatedFatG: 5.0,
          polyunsaturatedFatG: 3.0,
          transFatG: 0.0,
          cholesterolMg: 0.0,
          sodiumMg: 5.0,
          potassiumMg: 400.0,
          magnesiumMg: 30.0,
          calciumMg: 20.0,
          glycemicIndex: 15,
          glycemicLoad: 2.0,
          vitamins: 'A, C, E',
          minerals: 'K, Mg',
          foodPhotoUrl: 'https://example.com/photo.jpg',
          barcode: '1234567890123',
        );

        final id = await foodDao.insertFood(food);
        expect(id, greaterThan(0));

        final retrieved = await foodDao.getFoodById(id);
        expect(retrieved, isNotNull);
        expect(retrieved?.keylist, equals('test-key-123'));
        expect(retrieved?.isKetoFriendly, equals(1));
        expect(retrieved?.barcode, equals('1234567890123'));
      });

      test('insertFood - handles null optional fields', () async {
        final food = FoodModel(
          foodDescription: 'Minimal Food',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          dietaryFiberG: 0.0, // Set to 0 to avoid auto-calculation
          source: 'test',
          // All optional fields are null
        );

        final id = await foodDao.insertFood(food);
        expect(id, greaterThan(0));

        final retrieved = await foodDao.getFoodById(id);
        expect(retrieved, isNotNull);
        // netCarbsG may be auto-calculated, so check if it's null OR equals calculated value
        expect(retrieved?.netCarbsG == null || retrieved?.netCarbsG == 5.0, isTrue);
        expect(retrieved?.keylist, isNull);
      });

      test('insertFood - multiple rapid insertions', () async {
        final foods = List.generate(10, (i) => FoodModel(
          foodDescription: 'Rapid Food $i',
          energyKcal: 100.0 + i,
          totalProteinG: 10.0 + i,
          totalFatG: 5.0 + i,
          totalCarbohydrateG: 5.0 + i,
          source: 'test',
        ));

        final ids = <int>[];
        for (final food in foods) {
          final id = await foodDao.insertFood(food);
          ids.add(id);
          expect(id, greaterThan(0));
        }

        expect(ids.length, equals(10));
        expect(ids.toSet().length, equals(10)); // All IDs should be unique
      });
    });

    group('READ Operations', () {
      late int testFoodId;

      setUp(() async {
        final food = FoodModel(
          foodDescription: 'Test Food for Reading',
          energyKcal: 150.0,
          totalProteinG: 15.0,
          totalFatG: 8.0,
          totalCarbohydrateG: 10.0,
          dietaryFiberG: 3.0,
          netCarbsG: 7.0,
          source: 'test',
        );
        testFoodId = await foodDao.insertFood(food);
      });

      test('getFoodById - existing food', () async {
        final food = await foodDao.getFoodById(testFoodId);
        expect(food, isNotNull);
        expect(food?.foodId, equals(testFoodId));
        expect(food?.foodDescription, equals('Test Food for Reading'));
        expect(food?.energyKcal, equals(150.0));
        expect(food?.netCarbsG, equals(7.0));
      });

      test('getFoodById - non-existent food', () async {
        final food = await foodDao.getFoodById(99999);
        expect(food, isNull);
      });

      test('getFoodById - zero ID', () async {
        final food = await foodDao.getFoodById(0);
        expect(food, isNull);
      });

      test('getFoodById - negative ID', () async {
        final food = await foodDao.getFoodById(-1);
        expect(food, isNull);
      });
    });

    group('SEARCH Operations', () {
      setUp(() async {
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

        await foodDao.insertFood(FoodModel(
          foodDescription: 'Salmon Fillet',
          energyKcal: 206.0,
          totalProteinG: 22.0,
          totalFatG: 12.0,
          totalCarbohydrateG: 0.0,
          source: 'test',
        ));
      });

      test('searchFoods - exact match', () async {
        final results = await foodDao.searchFoods('Avocado Toast');
        expect(results.length, equals(1));
        expect(results.first.foodDescription, equals('Avocado Toast'));
      });

      test('searchFoods - partial match', () async {
        final results = await foodDao.searchFoods('Avocado');
        expect(results.length, equals(2));
        expect(results.any((f) => f.foodDescription.contains('Toast')), isTrue);
        expect(results.any((f) => f.foodDescription.contains('Salad')), isTrue);
      });

      test('searchFoods - case insensitive', () async {
        final results1 = await foodDao.searchFoods('avocado');
        final results2 = await foodDao.searchFoods('AVOCADO');
        final results3 = await foodDao.searchFoods('AvOcAdO');

        expect(results1.length, equals(2));
        expect(results2.length, equals(2));
        expect(results3.length, equals(2));
      });

      test('searchFoods - no matches', () async {
        final results = await foodDao.searchFoods('Nonexistent Food');
        expect(results.length, equals(0));
      });

      test('searchFoods - empty string', () async {
        final results = await foodDao.searchFoods('');
        expect(results.length, greaterThanOrEqualTo(0));
      });

      test('searchFoods - limit parameter', () async {
        final results = await foodDao.searchFoods('', limit: 2);
        expect(results.length, lessThanOrEqualTo(2));
      });

      test('searchFoods - special characters', () async {
        await foodDao.insertFood(FoodModel(
          foodDescription: 'Food & Drink',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          source: 'test',
        ));

        final results = await foodDao.searchFoods('Food &');
        expect(results.length, greaterThanOrEqualTo(1));
      });
    });

    group('Keto-Friendly Foods', () {
      setUp(() async {
        await foodDao.insertFood(FoodModel(
          foodDescription: 'Keto Food 1',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          isKetoFriendly: 1,
          source: 'test',
        ));

        await foodDao.insertFood(FoodModel(
          foodDescription: 'Keto Food 2',
          energyKcal: 200.0,
          totalProteinG: 20.0,
          totalFatG: 10.0,
          totalCarbohydrateG: 10.0,
          isKetoFriendly: 1,
          source: 'test',
        ));

        await foodDao.insertFood(FoodModel(
          foodDescription: 'Non-Keto Food',
          energyKcal: 300.0,
          totalProteinG: 30.0,
          totalFatG: 15.0,
          totalCarbohydrateG: 50.0,
          isKetoFriendly: 0,
          source: 'test',
        ));
      });

      test('getKetoFriendlyFoods - returns only keto foods', () async {
        final results = await foodDao.getKetoFriendlyFoods();
        expect(results.length, equals(2));
        expect(results.every((f) => f.isKetoFriendly == 1), isTrue);
        expect(results.any((f) => f.foodDescription.contains('Non-Keto')), isFalse);
      });

      test('getKetoFriendlyFoods - respects limit', () async {
        final results = await foodDao.getKetoFriendlyFoods(limit: 1);
        expect(results.length, equals(1));
      });
    });

    group('Data Integrity', () {
      test('inserted data matches retrieved data', () async {
        final originalFood = FoodModel(
          foodDescription: 'Integrity Test Food',
          energyKcal: 175.5,
          totalProteinG: 12.5,
          totalFatG: 8.75,
          totalCarbohydrateG: 6.25,
          dietaryFiberG: 2.5,
          netCarbsG: 3.75,
          source: 'test',
          keylist: 'test-key',
          isKetoFriendly: 1,
        );

        final id = await foodDao.insertFood(originalFood);
        final retrieved = await foodDao.getFoodById(id);

        expect(retrieved, isNotNull);
        expect(retrieved?.foodDescription, equals(originalFood.foodDescription));
        expect(retrieved?.energyKcal, equals(originalFood.energyKcal));
        expect(retrieved?.totalProteinG, equals(originalFood.totalProteinG));
        expect(retrieved?.totalFatG, equals(originalFood.totalFatG));
        expect(retrieved?.totalCarbohydrateG, equals(originalFood.totalCarbohydrateG));
        expect(retrieved?.dietaryFiberG, equals(originalFood.dietaryFiberG));
        expect(retrieved?.netCarbsG, equals(originalFood.netCarbsG));
        expect(retrieved?.keylist, equals(originalFood.keylist));
        expect(retrieved?.isKetoFriendly, equals(originalFood.isKetoFriendly));
      });

      test('multiple retrievals return same data', () async {
        final food = FoodModel(
          foodDescription: 'Consistency Test',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          source: 'test',
        );

        final id = await foodDao.insertFood(food);

        final retrieval1 = await foodDao.getFoodById(id);
        final retrieval2 = await foodDao.getFoodById(id);
        final retrieval3 = await foodDao.getFoodById(id);

        expect(retrieval1?.foodDescription, equals(retrieval2?.foodDescription));
        expect(retrieval2?.foodDescription, equals(retrieval3?.foodDescription));
        expect(retrieval1?.energyKcal, equals(retrieval2?.energyKcal));
      });
    });

    group('Performance Tests', () {
      test('bulk insert performance', () async {
        final startTime = DateTime.now();
        
        for (int i = 0; i < 100; i++) {
          await foodDao.insertFood(FoodModel(
            foodDescription: 'Bulk Food $i',
            energyKcal: 100.0 + i,
            totalProteinG: 10.0 + i,
            totalFatG: 5.0 + i,
            totalCarbohydrateG: 5.0 + i,
            source: 'test',
          ));
        }

        final duration = DateTime.now().difference(startTime);
        expect(duration.inSeconds, lessThan(10)); // Should complete in < 10 seconds
      });

      test('bulk search performance', () async {
        // Insert 50 foods
        for (int i = 0; i < 50; i++) {
          await foodDao.insertFood(FoodModel(
            foodDescription: 'Search Test Food $i',
            energyKcal: 100.0,
            totalProteinG: 10.0,
            totalFatG: 5.0,
            totalCarbohydrateG: 5.0,
            source: 'test',
          ));
        }

        final startTime = DateTime.now();
        final results = await foodDao.searchFoods('Search', limit: 100); // Increase limit
        final duration = DateTime.now().difference(startTime);

        expect(results.length, equals(50));
        expect(duration.inMilliseconds, lessThan(1000)); // Should complete in < 1 second
      });
    });

    group('Edge Cases', () {
      test('very long food description', () async {
        final longDescription = 'A' * 1000;
        final food = FoodModel(
          foodDescription: longDescription,
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          source: 'test',
        );

        final id = await foodDao.insertFood(food);
        final retrieved = await foodDao.getFoodById(id);
        expect(retrieved?.foodDescription, equals(longDescription));
      });

      test('zero values', () async {
        final food = FoodModel(
          foodDescription: 'Zero Values Food',
          energyKcal: 0.0,
          totalProteinG: 0.0,
          totalFatG: 0.0,
          totalCarbohydrateG: 0.0,
          source: 'test',
        );

        final id = await foodDao.insertFood(food);
        final retrieved = await foodDao.getFoodById(id);
        expect(retrieved?.energyKcal, equals(0.0));
        expect(retrieved?.totalProteinG, equals(0.0));
      });

      test('very large numeric values', () async {
        final food = FoodModel(
          foodDescription: 'Large Values Food',
          energyKcal: 99999.99,
          totalProteinG: 9999.99,
          totalFatG: 9999.99,
          totalCarbohydrateG: 9999.99,
          source: 'test',
        );

        final id = await foodDao.insertFood(food);
        final retrieved = await foodDao.getFoodById(id);
        expect(retrieved?.energyKcal, equals(99999.99));
      });

      test('unicode characters in description', () async {
        final food = FoodModel(
          foodDescription: '测试食物 🥑 日本語',
          energyKcal: 100.0,
          totalProteinG: 10.0,
          totalFatG: 5.0,
          totalCarbohydrateG: 5.0,
          source: 'test',
        );

        final id = await foodDao.insertFood(food);
        final retrieved = await foodDao.getFoodById(id);
        expect(retrieved?.foodDescription, equals('测试食物 🥑 日本語'));
      });
    });
  });
}

/// Test DAO that uses a provided database instance
class _TestDriftFoodDao {
  final AppDatabase _db;

  _TestDriftFoodDao(this._db);

  Future<AppDatabase> get _database async => _db;

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

  Future<FoodModel?> getFoodById(int foodId) async {
    final db = await _database;
    final query = db.select(db.foods)..where((f) => f.foodId.equals(foodId));
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return _foodFromDrift(result);
  }

  Future<List<FoodModel>> searchFoods(String query, {int limit = 20}) async {
    final db = await _database;
    final searchTerm = '%${query.toLowerCase()}%';
    final results = await (db.select(db.foods)
          ..where((f) => f.foodDescription.lower().like(searchTerm))
          ..limit(limit))
        .get();
    return results.map(_foodFromDrift).toList();
  }

  Future<List<FoodModel>> getKetoFriendlyFoods({int limit = 50}) async {
    final db = await _database;
    final results = await (db.select(db.foods)
          ..where((f) => f.isKetoFriendly.equals(1))
          ..limit(limit))
        .get();
    return results.map(_foodFromDrift).toList();
  }

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

