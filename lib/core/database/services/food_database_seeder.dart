import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
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
      //check localStorage flag (diagnostic for persistence issues)
      final prefs = await SharedPreferences.getInstance();
      final wasSeededBefore = prefs.getBool('database_seeded') ?? false;
      
      final count = await _foodDao.getFoodsCount();
      debugPrint('[SEEDER] 📊 Current food count: $count');
      debugPrint('[SEEDER] 📊 localStorage says seeded before: $wasSeededBefore');
      
      if (count == 0) {
        if (wasSeededBefore && kIsWeb) {
          //localStorage says we seeded before, but DB is empty - IndexedDB issue!
          debugPrint('[SEEDER] ⚠️ PERSISTENCE BUG: localStorage says seeded, but DB is empty!');
          debugPrint('[SEEDER] ⚠️ IndexedDB data was lost between sessions');
        }
        
        debugPrint('[SEEDER] 🌱 Database empty, seeding with NCC sample data...');
        await _seedDatabase();
        _isSeeded = true;
        
        //save flag to localStorage for next session
        await prefs.setBool('database_seeded', true);
        debugPrint('[SEEDER] ✅ Database seeded successfully with ${nccSampleFoods.length} foods');
      } else {
        debugPrint('[SEEDER] ✅ Database already has $count foods, skipping seed');
        _isSeeded = true;
        
        //ensure flag is set
        if (!wasSeededBefore) {
          await prefs.setBool('database_seeded', true);
        }
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
