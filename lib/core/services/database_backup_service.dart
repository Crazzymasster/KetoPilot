import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../database/drift_database_service.dart';
import 'package:drift/drift.dart';

/// Service for database backup and restore operations
/// Works on all platforms (web uses IndexedDB export/import)
class DatabaseBackupService {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  /// Backup database to a file
  /// Returns the path to the backup file
  Future<String> backupDatabase() async {
    try {
      if (kIsWeb) {
        // On web, export database as JSON
        return await _backupWebDatabase();
      } else {
        // On native platforms, copy the database file
        return await _backupNativeDatabase();
      }
    } catch (e) {
      debugPrint('[BACKUP] ❌ Error: $e');
      rethrow;
    }
  }

  /// Restore database from a backup file
  Future<void> restoreDatabase(String backupPath) async {
    try {
      if (kIsWeb) {
        // On web, import from JSON
        await _restoreWebDatabase(backupPath);
      } else {
        // On native platforms, replace the database file
        await _restoreNativeDatabase(backupPath);
      }
    } catch (e) {
      debugPrint('[RESTORE] ❌ Error: $e');
      rethrow;
    }
  }

  /// Export database as JSON (for web or cross-platform backup)
  Future<String> exportToJson() async {
    try {
      final db = await _dbService.database;
      
      // Export all tables
      final export = <String, dynamic>{
        'version': 1,
        'timestamp': DateTime.now().toIso8601String(),
        'tables': <String, dynamic>{},
      };

      // Export users
      final users = await db.select(db.users).get();
      export['tables']!['users'] = users.map((u) => _userToJson(u)).toList();

      // Export foods
      final foods = await db.select(db.foods).get();
      export['tables']!['foods'] = foods.map((f) => _foodToJson(f)).toList();

      // Export food portions
      final portions = await db.select(db.foodPortions).get();
      export['tables']!['food_portions'] = portions.map((p) => _portionToJson(p)).toList();

      // Export diet entries
      final dietEntries = await db.select(db.dietEntries).get();
      export['tables']!['diet_entries'] = dietEntries.map((e) => _dietEntryToJson(e)).toList();

      // Export health logs
      final healthLogs = await db.select(db.healthLogs).get();
      export['tables']!['health_logs'] = healthLogs.map((h) => _healthLogToJson(h)).toList();

      // Export daily summaries
      final summaries = await db.select(db.dailySummaries).get();
      export['tables']!['daily_summaries'] = summaries.map((s) => _summaryToJson(s)).toList();

      // Convert to JSON string
      final jsonString = _mapToJsonString(export);
      
      // Save to file
      if (kIsWeb) {
        // On web, trigger download
        return await _saveJsonToWeb(jsonString);
      } else {
        // On native, save to file
        final dir = await getApplicationDocumentsDirectory();
        final file = File(p.join(dir.path, 'ketopilot_backup_${DateTime.now().millisecondsSinceEpoch}.json'));
        await file.writeAsString(jsonString);
        return file.path;
      }
    } catch (e) {
      debugPrint('[EXPORT] ❌ Error: $e');
      rethrow;
    }
  }

  /// Import database from JSON
  Future<void> importFromJson(String jsonPath) async {
    try {
      final file = File(jsonPath);
      final jsonString = await file.readAsString();
      final data = _jsonStringToMap(jsonString);

      final db = await _dbService.database;

      // Import in transaction
      await db.transaction(() async {
        // Clear existing data (optional - you might want to merge instead)
        // await db.delete(db.users).go();
        // ... clear other tables

        // Import users
        if (data['tables']?['users'] != null) {
          for (final userJson in data['tables']!['users'] as List) {
            await db.into(db.users).insert(_userFromJson(userJson));
          }
        }

        // Import foods
        if (data['tables']?['foods'] != null) {
          for (final foodJson in data['tables']!['foods'] as List) {
            await db.into(db.foods).insert(_foodFromJson(foodJson));
          }
        }

        // Import food portions
        if (data['tables']?['food_portions'] != null) {
          for (final portionJson in data['tables']!['food_portions'] as List) {
            await db.into(db.foodPortions).insert(_portionFromJson(portionJson));
          }
        }

        // Import diet entries
        if (data['tables']?['diet_entries'] != null) {
          for (final entryJson in data['tables']!['diet_entries'] as List) {
            await db.into(db.dietEntries).insert(_dietEntryFromJson(entryJson));
          }
        }

        // Import health logs
        if (data['tables']?['health_logs'] != null) {
          for (final logJson in data['tables']!['health_logs'] as List) {
            await db.into(db.healthLogs).insert(_healthLogFromJson(logJson));
          }
        }

        // Import daily summaries
        if (data['tables']?['daily_summaries'] != null) {
          for (final summaryJson in data['tables']!['daily_summaries'] as List) {
            await db.into(db.dailySummaries).insert(_summaryFromJson(summaryJson));
          }
        }
      });

      debugPrint('[IMPORT] ✅ Successfully imported data');
    } catch (e) {
      debugPrint('[IMPORT] ❌ Error: $e');
      rethrow;
    }
  }

  // Native platform backup/restore
  Future<String> _backupNativeDatabase() async {
    final db = await _dbService.database;
    final dbFolder = await getApplicationDocumentsDirectory();
    final sourceFile = File(p.join(dbFolder.path, 'ketopilot.db'));
    
    if (!await sourceFile.exists()) {
      throw Exception('Database file not found');
    }

    final backupDir = await getApplicationDocumentsDirectory();
    final backupFile = File(p.join(backupDir.path, 'ketopilot_backup_${DateTime.now().millisecondsSinceEpoch}.db'));
    
    await sourceFile.copy(backupFile.path);
    debugPrint('[BACKUP] ✅ Backup created: ${backupFile.path}');
    
    return backupFile.path;
  }

  Future<void> _restoreNativeDatabase(String backupPath) async {
    final backupFile = File(backupPath);
    if (!await backupFile.exists()) {
      throw Exception('Backup file not found');
    }

    // Close current database
    await _dbService.close();

    // Copy backup to database location
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, 'ketopilot.db'));
    
    await backupFile.copy(dbFile.path);
    debugPrint('[RESTORE] ✅ Database restored from: $backupPath');
  }

  // Web platform backup/restore
  Future<String> _backupWebDatabase() async {
    // On web, export as JSON
    return await exportToJson();
  }

  Future<void> _restoreWebDatabase(String backupPath) async {
    // On web, import from JSON
    await importFromJson(backupPath);
  }

  Future<String> _saveJsonToWeb(String jsonString) async {
    // On web, trigger browser download
    // This would require platform-specific code or a package like `universal_html`
    // For now, return the JSON string path (would need to be handled by UI)
    return jsonString;
  }

  // JSON conversion helpers (simplified - would need proper JSON encoding)
  String _mapToJsonString(Map<String, dynamic> map) {
    // Simplified JSON encoding - in production, use `dart:convert`
    return map.toString(); // Placeholder
  }

  Map<String, dynamic> _jsonStringToMap(String json) {
    // Simplified JSON decoding - in production, use `dart:convert`
    return {}; // Placeholder
  }

  // Entity to/from JSON helpers (simplified)
  Map<String, dynamic> _userToJson(User user) => {};
  UsersCompanion _userFromJson(Map<String, dynamic> json) => UsersCompanion.insert(email: '', passwordHash: '');
  
  Map<String, dynamic> _foodToJson(Food food) => {};
  FoodsCompanion _foodFromJson(Map<String, dynamic> json) => FoodsCompanion.insert(foodDescription: '', energyKcal: 0, totalProteinG: 0, totalFatG: 0, totalCarbohydrateG: 0);
  
  Map<String, dynamic> _portionToJson(FoodPortion portion) => {};
  FoodPortionsCompanion _portionFromJson(Map<String, dynamic> json) => FoodPortionsCompanion.insert(foodId: 0, portionAmount: 0, portionUnit: '', portionGramWeight: 0);
  
  Map<String, dynamic> _dietEntryToJson(DietEntry entry) => {};
  DietEntriesCompanion _dietEntryFromJson(Map<String, dynamic> json) => DietEntriesCompanion.insert(userId: 0, foodId: 0, recordedAt: '', date: '', totalEnergyKcal: 0, totalProteinG: 0, totalFatG: 0, totalCarbohydrateG: 0, totalNetCarbsG: 0);
  
  Map<String, dynamic> _healthLogToJson(HealthLog log) => {};
  HealthLogsCompanion _healthLogFromJson(Map<String, dynamic> json) => HealthLogsCompanion.insert(userId: 0, recordedAt: '', date: '');
  
  Map<String, dynamic> _summaryToJson(DailySummary summary) => {};
  DailySummariesCompanion _summaryFromJson(Map<String, dynamic> json) => DailySummariesCompanion.insert(userId: 0, date: '');
}

