import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import '../drift_database_service.dart';
import '../drift_database.dart';
import '../models/diet_entry_model.dart';

/// Diet Entry DAO using Drift (works on all platforms including web)
class DriftDietEntryDao {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  Future<AppDatabase> get _db async {
    try {
      return await _dbService.database;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Error: $e');
      rethrow;
    }
  }

  /// Insert a new diet entry
  Future<int> insertDietEntry(DietEntryModel entry) async {
    try {
      final db = await _db;
      final id = await db.into(db.dietEntries).insert(
        DietEntriesCompanion(
          userId: Value(entry.userId),
          foodId: Value(entry.foodId),
          recordedAt: Value(entry.recordedAt),
          date: Value(entry.date),
          portionId: Value(entry.portionId),
          customPortionGrams: Value(entry.customPortionGrams),
          servingSizeMultiplier: Value(entry.servingSizeMultiplier),
          totalEnergyKcal: Value(entry.totalEnergyKcal),
          totalProteinG: Value(entry.totalProteinG),
          totalFatG: Value(entry.totalFatG),
          totalCarbohydrateG: Value(entry.totalCarbohydrateG),
          totalNetCarbsG: Value(entry.totalNetCarbsG),
          totalFiberG: Value(entry.totalFiberG),
          totalSodiumMg: Value(entry.totalSodiumMg),
          mealContext: Value(entry.mealContext),
          location: Value(entry.location),
          notes: Value(entry.notes),
          foodPhotoUrl: Value(entry.foodPhotoUrl),
        ),
      );
      return id;
    } catch (e, stackTrace) {
      debugPrint('[DIET ENTRY DAO] ❌ Insert error: $e');
      rethrow;
    }
  }

  /// Get diet entries for a user on a specific date
  Future<List<DietEntryModel>> getDietEntriesByDate(
    int userId,
    String date,
  ) async {
    try {
      final db = await _db;
      final query = db.select(db.dietEntries)
        ..where((e) => e.userId.equals(userId) & e.date.equals(date))
        ..orderBy([(e) => OrderingTerm(expression: e.recordedAt)]);
      final results = await query.get();
      
      return results.map(_dietEntryFromDrift).toList();
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get by date error: $e');
      rethrow;
    }
  }

  /// Get diet entry by ID
  Future<DietEntryModel?> getDietEntryById(int entryId) async {
    try {
      final db = await _db;
      final query = db.select(db.dietEntries)..where((e) => e.entryId.equals(entryId));
      final result = await query.getSingleOrNull();
      return result != null ? _dietEntryFromDrift(result) : null;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get by ID error: $e');
      rethrow;
    }
  }

  /// Update diet entry
  Future<int> updateDietEntry(DietEntryModel entry) async {
    try {
      if (entry.entryId == null) {
        throw ArgumentError('Entry ID is required for update');
      }
      final db = await _db;
      final updated = await (db.update(db.dietEntries)
            ..where((e) => e.entryId.equals(entry.entryId!)))
          .write(
        DietEntriesCompanion(
          recordedAt: Value(entry.recordedAt),
          date: Value(entry.date),
          servingSizeMultiplier: Value(entry.servingSizeMultiplier),
          totalEnergyKcal: Value(entry.totalEnergyKcal),
          totalProteinG: Value(entry.totalProteinG),
          totalFatG: Value(entry.totalFatG),
          totalCarbohydrateG: Value(entry.totalCarbohydrateG),
          totalNetCarbsG: Value(entry.totalNetCarbsG),
          totalFiberG: Value(entry.totalFiberG),
          totalSodiumMg: Value(entry.totalSodiumMg),
          notes: Value(entry.notes),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
      return updated;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Update error: $e');
      rethrow;
    }
  }

  /// Delete diet entry
  Future<int> deleteDietEntry(int entryId) async {
    try {
      final db = await _db;
      final deleted = await (db.delete(db.dietEntries)
            ..where((e) => e.entryId.equals(entryId)))
          .go();
      return deleted;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Delete error: $e');
      rethrow;
    }
  }

  /// Get diet entries for a user within a date range
  Future<List<DietEntryModel>> getDietEntriesByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    try {
      final db = await _db;
      final query = db.select(db.dietEntries)
        ..where((e) => e.userId.equals(userId) & 
                      e.date.isBiggerOrEqualValue(startDate) & 
                      e.date.isSmallerOrEqualValue(endDate))
        ..orderBy([(e) => OrderingTerm(expression: e.date), (e) => OrderingTerm(expression: e.recordedAt)]);
      final results = await query.get();
      
      return results.map(_dietEntryFromDrift).toList();
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get by date range error: $e');
      rethrow;
    }
  }

  /// Get daily totals for a user on a specific date
  /// OPTIMIZED: Uses SQL SUM aggregation instead of fetching all records
  Future<Map<String, double>> getDailyTotals(int userId, String date) async {
    try {
      final db = await _db;
      
      // Use SQL aggregation for better performance - single query instead of N records
      final query = db.selectOnly(db.dietEntries)
        ..addColumns([
          db.dietEntries.totalEnergyKcal.sum(),
          db.dietEntries.totalProteinG.sum(),
          db.dietEntries.totalFatG.sum(),
          db.dietEntries.totalCarbohydrateG.sum(),
          db.dietEntries.totalNetCarbsG.sum(),
          db.dietEntries.totalFiberG.sum(),
          db.dietEntries.totalSodiumMg.sum(),
        ])
        ..where(db.dietEntries.userId.equals(userId) & db.dietEntries.date.equals(date));
      
      final result = await query.getSingleOrNull();
      
      return {
        'total_energy_kcal': result?.read(db.dietEntries.totalEnergyKcal.sum()) ?? 0.0,
        'total_protein_g': result?.read(db.dietEntries.totalProteinG.sum()) ?? 0.0,
        'total_fat_g': result?.read(db.dietEntries.totalFatG.sum()) ?? 0.0,
        'total_carbohydrate_g': result?.read(db.dietEntries.totalCarbohydrateG.sum()) ?? 0.0,
        'total_net_carbs_g': result?.read(db.dietEntries.totalNetCarbsG.sum()) ?? 0.0,
        'total_fiber_g': result?.read(db.dietEntries.totalFiberG.sum()) ?? 0.0,
        'total_sodium_mg': result?.read(db.dietEntries.totalSodiumMg.sum()) ?? 0.0,
      };
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get daily totals error: $e');
      rethrow;
    }
  }

  /// Get daily totals for multiple dates in a single query
  /// OPTIMIZED: Single query for date range instead of N queries
  Future<Map<String, Map<String, double>>> getDailyTotalsForRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    try {
      final db = await _db;
      
      final query = db.selectOnly(db.dietEntries)
        ..addColumns([
          db.dietEntries.date,
          db.dietEntries.totalEnergyKcal.sum(),
          db.dietEntries.totalProteinG.sum(),
          db.dietEntries.totalFatG.sum(),
          db.dietEntries.totalCarbohydrateG.sum(),
          db.dietEntries.totalNetCarbsG.sum(),
          db.dietEntries.totalFiberG.sum(),
          db.dietEntries.totalSodiumMg.sum(),
        ])
        ..where(db.dietEntries.userId.equals(userId) & 
                db.dietEntries.date.isBiggerOrEqualValue(startDate) & 
                db.dietEntries.date.isSmallerOrEqualValue(endDate))
        ..groupBy([db.dietEntries.date]);
      
      final results = await query.get();
      final totalsMap = <String, Map<String, double>>{};
      
      for (final row in results) {
        final date = row.read(db.dietEntries.date) ?? '';
        totalsMap[date] = {
          'total_energy_kcal': row.read(db.dietEntries.totalEnergyKcal.sum()) ?? 0.0,
          'total_protein_g': row.read(db.dietEntries.totalProteinG.sum()) ?? 0.0,
          'total_fat_g': row.read(db.dietEntries.totalFatG.sum()) ?? 0.0,
          'total_carbohydrate_g': row.read(db.dietEntries.totalCarbohydrateG.sum()) ?? 0.0,
          'total_net_carbs_g': row.read(db.dietEntries.totalNetCarbsG.sum()) ?? 0.0,
          'total_fiber_g': row.read(db.dietEntries.totalFiberG.sum()) ?? 0.0,
          'total_sodium_mg': row.read(db.dietEntries.totalSodiumMg.sum()) ?? 0.0,
        };
      }
      
      return totalsMap;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get daily totals range error: $e');
      rethrow;
    }
  }

  /// Convert Drift DietEntry to DietEntryModel
  DietEntryModel _dietEntryFromDrift(DietEntry row) {
    return DietEntryModel(
      entryId: row.entryId,
      userId: row.userId,
      foodId: row.foodId,
      recordedAt: row.recordedAt,
      date: row.date,
      portionId: row.portionId,
      customPortionGrams: row.customPortionGrams,
      servingSizeMultiplier: row.servingSizeMultiplier,
      totalEnergyKcal: row.totalEnergyKcal,
      totalProteinG: row.totalProteinG,
      totalFatG: row.totalFatG,
      totalCarbohydrateG: row.totalCarbohydrateG,
      totalNetCarbsG: row.totalNetCarbsG,
      totalFiberG: row.totalFiberG,
      totalSodiumMg: row.totalSodiumMg,
      mealContext: row.mealContext,
      location: row.location,
      notes: row.notes,
      foodPhotoUrl: row.foodPhotoUrl,
      synced: row.synced,
      cloudId: row.cloudId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  //=== SYNC METHODS ===

  /// Get all unsynced diet entries for a user
  Future<List<DietEntryModel>> getUnsyncedEntries(int userId) async {
    try {
      final db = await _db;
      final query = db.select(db.dietEntries)
        ..where((e) => e.userId.equals(userId) & e.synced.equals(0));
      final results = await query.get();
      return results.map(_dietEntryFromDrift).toList();
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get unsynced error: $e');
      rethrow;
    }
  }

  /// Mark entry as synced with cloud ID
  Future<void> markAsSynced(int entryId, String cloudId) async {
    try {
      final db = await _db;
      await (db.update(db.dietEntries)
            ..where((e) => e.entryId.equals(entryId)))
          .write(DietEntriesCompanion(
        synced: const Value(1),
        cloudId: Value(cloudId),
        updatedAt: Value(DateTime.now().toIso8601String()),
      ));
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Mark synced error: $e');
      rethrow;
    }
  }

  /// Check if cloud entry exists locally
  Future<DietEntryModel?> getByCloudId(String cloudId) async {
    try {
      final db = await _db;
      final query = db.select(db.dietEntries)
        ..where((e) => e.cloudId.equals(cloudId));
      final result = await query.getSingleOrNull();
      return result != null ? _dietEntryFromDrift(result) : null;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get by cloudId error: $e');
      rethrow;
    }
  }

  /// Insert entry from cloud (already synced)
  Future<int> insertFromCloud(DietEntryModel entry) async {
    try {
      final db = await _db;
      final id = await db.into(db.dietEntries).insert(
        DietEntriesCompanion(
          userId: Value(entry.userId),
          foodId: Value(entry.foodId),
          recordedAt: Value(entry.recordedAt),
          date: Value(entry.date),
          portionId: Value(entry.portionId),
          customPortionGrams: Value(entry.customPortionGrams),
          servingSizeMultiplier: Value(entry.servingSizeMultiplier),
          totalEnergyKcal: Value(entry.totalEnergyKcal),
          totalProteinG: Value(entry.totalProteinG),
          totalFatG: Value(entry.totalFatG),
          totalCarbohydrateG: Value(entry.totalCarbohydrateG),
          totalNetCarbsG: Value(entry.totalNetCarbsG),
          totalFiberG: Value(entry.totalFiberG),
          totalSodiumMg: Value(entry.totalSodiumMg),
          mealContext: Value(entry.mealContext),
          location: Value(entry.location),
          notes: Value(entry.notes),
          foodPhotoUrl: Value(entry.foodPhotoUrl),
          synced: const Value(1),  //already synced from cloud
          cloudId: Value(entry.cloudId),
          createdAt: Value(entry.createdAt),
          updatedAt: Value(entry.updatedAt),
        ),
      );
      return id;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Insert from cloud error: $e');
      rethrow;
    }
  }

  /// Get all entries for a user (for full sync)
  Future<List<DietEntryModel>> getAllEntriesForUser(int userId) async {
    try {
      final db = await _db;
      final query = db.select(db.dietEntries)
        ..where((e) => e.userId.equals(userId))
        ..orderBy([(e) => OrderingTerm.desc(e.recordedAt)]);
      final results = await query.get();
      return results.map(_dietEntryFromDrift).toList();
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get all entries error: $e');
      rethrow;
    }
  }

  /// Batch insert multiple diet entries (optimized for imports/sync)
  Future<List<int>> insertDietEntriesBatch(List<DietEntryModel> entries) async {
    if (entries.isEmpty) return [];
    
    try {
      final db = await _db;
      final ids = <int>[];
      
      // Use transaction for atomic batch insert
      await db.transaction(() async {
        for (final entry in entries) {
          final id = await db.into(db.dietEntries).insert(
            DietEntriesCompanion(
              userId: Value(entry.userId),
              foodId: Value(entry.foodId),
              recordedAt: Value(entry.recordedAt),
              date: Value(entry.date),
              portionId: Value(entry.portionId),
              customPortionGrams: Value(entry.customPortionGrams),
              servingSizeMultiplier: Value(entry.servingSizeMultiplier),
              totalEnergyKcal: Value(entry.totalEnergyKcal),
              totalProteinG: Value(entry.totalProteinG),
              totalFatG: Value(entry.totalFatG),
              totalCarbohydrateG: Value(entry.totalCarbohydrateG),
              totalNetCarbsG: Value(entry.totalNetCarbsG),
              totalFiberG: Value(entry.totalFiberG),
              totalSodiumMg: Value(entry.totalSodiumMg),
              mealContext: Value(entry.mealContext),
              location: Value(entry.location),
              notes: Value(entry.notes),
              foodPhotoUrl: Value(entry.foodPhotoUrl),
              synced: Value(entry.synced ?? 0),
              cloudId: Value(entry.cloudId),
            ),
          );
          ids.add(id);
        }
      });
      
      debugPrint('[DIET ENTRY DAO] ✅ Batch inserted ${ids.length} entries');
      return ids;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Batch insert error: $e');
      rethrow;
    }
  }

  /// Get entry count for a user on a specific date (lightweight)
  Future<int> getEntryCountByDate(int userId, String date) async {
    try {
      final db = await _db;
      final query = db.selectOnly(db.dietEntries)
        ..addColumns([db.dietEntries.entryId.count()])
        ..where(db.dietEntries.userId.equals(userId) & db.dietEntries.date.equals(date));
      final result = await query.getSingle();
      return result.read(db.dietEntries.entryId.count()) ?? 0;
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get count error: $e');
      return 0;
    }
  }
}
