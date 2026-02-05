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
  Future<Map<String, double>> getDailyTotals(int userId, String date) async {
    try {
      final db = await _db;
      final entries = await getDietEntriesByDate(userId, date);
      
      double totalEnergyKcal = 0.0;
      double totalProteinG = 0.0;
      double totalFatG = 0.0;
      double totalCarbohydrateG = 0.0;
      double totalNetCarbsG = 0.0;
      double totalFiberG = 0.0;
      double totalSodiumMg = 0.0;

      for (final entry in entries) {
        totalEnergyKcal += entry.totalEnergyKcal;
        totalProteinG += entry.totalProteinG;
        totalFatG += entry.totalFatG;
        totalCarbohydrateG += entry.totalCarbohydrateG;
        totalNetCarbsG += entry.totalNetCarbsG;
        totalFiberG += entry.totalFiberG ?? 0.0;
        totalSodiumMg += entry.totalSodiumMg ?? 0.0;
      }

      return {
        'total_energy_kcal': totalEnergyKcal,
        'total_protein_g': totalProteinG,
        'total_fat_g': totalFatG,
        'total_carbohydrate_g': totalCarbohydrateG,
        'total_net_carbs_g': totalNetCarbsG,
        'total_fiber_g': totalFiberG,
        'total_sodium_mg': totalSodiumMg,
      };
    } catch (e) {
      debugPrint('[DIET ENTRY DAO] ❌ Get daily totals error: $e');
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
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

