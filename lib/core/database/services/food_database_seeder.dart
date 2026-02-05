import 'package:flutter/foundation.dart' show debugPrint;
import '../daos/drift_food_dao.dart';
import '../data/ncc_sample_foods.dart';

/// Service to seed the food database with NCC sample data on first launch
class FoodDatabaseSeeder {
  final DriftFoodDao _foodDao = DriftFoodDao();
  
  static bool _isSeeded = false;
  
  /// Check if the database needs seeding and seed if necessary
  Future<void> seedIfNeeded() async {
    if (_isSeeded) {
      debugPrint('[SEEDER] ✅ Already seeded in this session');
      return;
    }
    
    try {
      final count = await _foodDao.getFoodsCount();
      debugPrint('[SEEDER] 📊 Current food count: $count');
      
      if (count == 0) {
        debugPrint('[SEEDER] 🌱 Database empty, seeding with NCC sample data...');
        await _seedDatabase();
        _isSeeded = true;
        debugPrint('[SEEDER] ✅ Database seeded successfully with ${nccSampleFoods.length} foods');
      } else {
        debugPrint('[SEEDER] ✅ Database already has $count foods, skipping seed');
        _isSeeded = true;
      }
    } catch (e) {
      debugPrint('[SEEDER] ❌ Seeding error: $e');
    }
  }
  
  /// Actually seed the database with NCC sample foods
  Future<void> _seedDatabase() async {
    await _foodDao.insertFoods(nccSampleFoods);
  }
  
  /// Force re-seed the database (for testing/development)
  Future<void> forceSeed() async {
    debugPrint('[SEEDER] 🔄 Force seeding database...');
    await _seedDatabase();
    _isSeeded = true;
    debugPrint('[SEEDER] ✅ Force seed complete');
  }
}
