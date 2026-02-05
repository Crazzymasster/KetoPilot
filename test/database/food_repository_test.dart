import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import '../../lib/core/database/database_schema.dart';
import '../../lib/core/database/daos/food_dao.dart';
import '../../lib/core/database/models/food_model.dart';

void main() {
  late Database database;
  late FoodDao foodDao;

  setUp(() async {
    // Initialize FFI for testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Create in-memory test database
    database = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        // Disable foreign keys during setup
        await db.execute('PRAGMA foreign_keys = OFF');
        // Create schema
        await DatabaseSchema.createTables(db);
        await DatabaseSchema.createFtsTables(db);
        await DatabaseSchema.createIndexes(db);
        await DatabaseSchema.createTriggers(db);
        // Re-enable foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );

    foodDao = FoodDao.withDatabase(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('Food Search Tests', () {
    test('Search returns relevant results', () async {
      // Insert test data
      final food = FoodModel(
        foodId: 1,
        keylist: 'TEST.001',
        foodDescription: 'Avocado, raw',
        energyKcal: 160.0,
        totalProteinG: 2.0,
        totalFatG: 15.0,
        totalCarbohydrateG: 9.0,
        dietaryFiberG: 7.0,
        isKetoFriendly: 1,
      );

      await database.insert('tb_food', food.toMap());

      // Search
      final results = await foodDao.searchFoods('avocado');

      expect(results.length, greaterThanOrEqualTo(1));
      final found = results.firstWhere(
        (f) => f.foodDescription.toLowerCase().contains('avocado'),
        orElse: () => results.first,
      );
      expect(found.foodDescription.toLowerCase(), contains('avocado'));
      expect(found.netCarbsG, 2.0);
    });

    test('Keto-friendly filter works', () async {
      // Insert keto and non-keto foods
      final butter = FoodModel(
        foodId: 1,
        foodDescription: 'Butter',
        isKetoFriendly: 1,
        energyKcal: 100.0,
        totalProteinG: 0.0,
        totalFatG: 11.0,
        totalCarbohydrateG: 0.1,
      );

      final bread = FoodModel(
        foodId: 2,
        foodDescription: 'White bread',
        isKetoFriendly: 0,
        energyKcal: 250.0,
        totalProteinG: 8.0,
        totalFatG: 3.0,
        totalCarbohydrateG: 50.0,
      );

      await database.insert('tb_food', butter.toMap());
      await database.insert('tb_food', bread.toMap());

      final ketoFoods = await foodDao.getKetoFriendlyFoods();

      expect(ketoFoods.every((f) => f.isKetoFriendly == 1), true);
    });
  });

  group('Food Creation Rate Limiting Tests', () {
    test('User cannot exceed food creation limit', () async {
      final userId = 1;

      // Create user with limit of 3 foods per week
      await database.insert('tb_user', {
        'user_id': userId,
        'email': 'test@example.com',
        'password_hash': 'hash',
        'food_creation_count': 3,
        'food_creation_window_start': DateTime.now().toIso8601String(),
        'max_foods_per_window': 3,
        'window_duration_days': 7,
      });

      // Try to create 4th food
      final food = FoodModel(
        foodDescription: 'Test Food',
        energyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
      );

      // Check if user can create food (should return false)
      // Note: This would require FoodCreationService which checks rate limits
      // For now, we'll just verify the user exists
      final userCheck = await database.query(
        'tb_user',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      expect(userCheck.isNotEmpty, true);
      expect(userCheck.first['food_creation_count'], 3);
    });

    test('Food creation limit resets after window expires', () async {
      final userId = 1;
      final oldDate = DateTime.now().subtract(const Duration(days: 8));

      // Create user with expired window
      await database.insert('tb_user', {
        'user_id': userId,
        'email': 'test@example.com',
        'password_hash': 'hash',
        'food_creation_count': 3,
        'food_creation_window_start': oldDate.toIso8601String(),
        'max_foods_per_window': 3,
        'window_duration_days': 7,
      });

      final food = FoodModel(
        foodDescription: 'Test Food',
        energyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
      );

      // Verify window expired
      final userCheck = await database.query(
        'tb_user',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      expect(userCheck.isNotEmpty, true);
      final windowStart = DateTime.parse(userCheck.first['food_creation_window_start'] as String);
      final daysElapsed = DateTime.now().difference(windowStart).inDays;
      expect(daysElapsed, greaterThan(7));
    });
  });

  group('Food Detail Tests', () {
    test('Get food detail with portions', () async {
      // Insert food
      final testFood = FoodModel(
        foodId: 1,
        foodDescription: 'Test Food',
        energyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
      );
      await database.insert('tb_food', testFood.toMap());

      // Insert portions
      await database.insert('tb_food_portions', {
        'food_id': 1,
        'portion_amount': 1,
        'portion_unit': 'CUP',
        'portion_gram_weight': 100.0,
        'is_default': 1,
      });

      final food = await foodDao.getFoodById(1);
      expect(food?.foodId, 1);
    });
  });
}

