import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import '../../lib/core/database/database_schema.dart';
import '../../lib/core/database/daos/diet_entry_dao.dart';
import '../../lib/core/database/models/diet_entry_model.dart';
import '../../lib/core/database/models/food_model.dart';

void main() {
  late Database database;
  late DietEntryDao dietEntryDao;

  setUp(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    database = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        // Disable foreign keys during setup
        await db.execute('PRAGMA foreign_keys = OFF');
        await DatabaseSchema.createTables(db);
        await DatabaseSchema.createFtsTables(db);
        await DatabaseSchema.createIndexes(db);
        await DatabaseSchema.createTriggers(db);
        // Re-enable foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );

    dietEntryDao = DietEntryDao.withDatabase(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('Diet Entry Tests', () {
    test('Add diet entry updates daily totals', () async {
      const userId = 1;

      // Create user
      await database.insert('tb_user', {
        'user_id': userId,
        'email': 'test@example.com',
        'password_hash': 'hash',
        'target_net_carbs': 20.0,
      });

      // Create food
      final food = FoodModel(
        foodId: 1,
        foodDescription: 'Test Food',
        energyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
        dietaryFiberG: 2.0,
      );
      await database.insert('tb_food', food.toMap());

      // Create diet entry
      final now = DateTime.now();
      final entry = DietEntryModel(
        userId: userId,
        foodId: 1,
        recordedAt: now.toIso8601String(),
        date: now.toIso8601String().split('T')[0],
        totalEnergyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
        totalNetCarbsG: 3.0,
      );

      await dietEntryDao.insertDietEntry(entry);

      // Check daily totals
      final dateStr = now.toIso8601String().split('T')[0];
      final totals = await dietEntryDao.getDailyTotals(userId, dateStr);
      expect(totals['total_net_carbs_g'], 3.0);
      expect(totals['total_protein_g'], 10.0);
    });

    test('Get entries by date range', () async {
      const userId = 1;

      // Create user
      await database.insert('tb_user', {
        'user_id': userId,
        'email': 'test@example.com',
        'password_hash': 'hash',
        'target_net_carbs': 20.0,
      });

      // Create food
      final food = FoodModel(
        foodId: 1,
        foodDescription: 'Test Food',
        energyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
        dietaryFiberG: 2.0,
      );
      await database.insert('tb_food', food.toMap());

      // Create test entries
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      final entry1 = DietEntryModel(
        userId: userId,
        foodId: 1,
        recordedAt: today.toIso8601String(),
        date: today.toIso8601String().split('T')[0],
        totalEnergyKcal: 100.0,
        totalProteinG: 10.0,
        totalFatG: 5.0,
        totalCarbohydrateG: 5.0,
        totalNetCarbsG: 3.0,
      );

      final entry2 = DietEntryModel(
        userId: userId,
        foodId: 1,
        recordedAt: yesterday.toIso8601String(),
        date: yesterday.toIso8601String().split('T')[0],
        totalEnergyKcal: 150.0,
        totalProteinG: 15.0,
        totalFatG: 8.0,
        totalCarbohydrateG: 8.0,
        totalNetCarbsG: 5.0,
      );

      await dietEntryDao.insertDietEntry(entry1);
      await dietEntryDao.insertDietEntry(entry2);

      final startStr = yesterday.toIso8601String().split('T')[0];
      final endStr = today.toIso8601String().split('T')[0];
      final entries = await dietEntryDao.getDietEntriesByDateRange(
        userId,
        startStr,
        endStr,
      );

      expect(entries.length, 2);
    });
  });
}

