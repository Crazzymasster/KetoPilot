import 'dart:convert';
import '../database/database_service.dart';
import '../database/daos/user_dao.dart';
import '../database/daos/diet_entry_dao.dart';
import '../database/daos/health_log_dao.dart';
import '../database/daos/vitals_dao.dart';
import '../database/daos/symptoms_dao.dart';
import '../database/daos/daily_summary_dao.dart';
import '../database/daos/medication_dao.dart';

/// Service for data export and GDPR compliance
class DataExportService {
  final DatabaseService _dbService = DatabaseService();
  final UserDao _userDao = UserDao();
  final DietEntryDao _dietEntryDao = DietEntryDao();
  final HealthLogDao _healthLogDao = HealthLogDao();
  final VitalsDao _vitalsDao = VitalsDao();
  final SymptomsDao _symptomsDao = SymptomsDao();
  final DailySummaryDao _summaryDao = DailySummaryDao();
  final MedicationDao _medicationDao = MedicationDao();

  /// Export all user data as JSON (GDPR Right to Access)
  Future<Map<String, dynamic>> exportUserData(int userId) async {
    return {
      'user_profile': await _exportUserProfile(userId),
      'diet_entries': await _exportDietEntries(userId),
      'health_logs': await _exportHealthLogs(userId),
      'vitals': await _exportVitals(userId),
      'symptoms': await _exportSymptoms(userId),
      'daily_summaries': await _exportDailySummaries(userId),
      'medications': await _exportMedications(userId),
      'export_timestamp': DateTime.now().toIso8601String(),
      'export_version': '1.0',
    };
  }

  /// Export user profile (without sensitive data)
  Future<Map<String, dynamic>> _exportUserProfile(int userId) async {
    final user = await _userDao.getUserById(userId);
    if (user == null) {
      return {};
    }

    final profile = user.toMap();
    // Remove sensitive fields
    profile.remove('password_hash');
    return profile;
  }

  /// Export diet entries with food details
  Future<List<Map<String, dynamic>>> _exportDietEntries(int userId) async {
    final db = await _dbService.database;
    final results = await db.rawQuery('''
      SELECT 
        de.*,
        f.food_description,
        f.energy_kcal,
        f.total_protein_g,
        f.total_fat_g,
        f.total_carbohydrate_g,
        f.net_carbs_g
      FROM tb_diet_entries de
      JOIN tb_food f ON de.food_id = f.food_id
      WHERE de.user_id = ?
      ORDER BY de.recorded_at DESC
    ''', [userId]);

    return results.map((map) => Map<String, dynamic>.from(map)).toList();
  }

  /// Export health logs
  Future<List<Map<String, dynamic>>> _exportHealthLogs(int userId) async {
    final logs = await _healthLogDao.getHealthLogsByDateRange(
      userId,
      DateTime(2000, 1, 1).toIso8601String().split('T')[0],
      DateTime.now().toIso8601String().split('T')[0],
    );

    return logs.map((log) => log.toMap()).toList();
  }

  /// Export vitals
  Future<List<Map<String, dynamic>>> _exportVitals(int userId) async {
    final vitals = await _vitalsDao.getVitalsByDateRange(
      userId,
      DateTime(2000, 1, 1).toIso8601String().split('T')[0],
      DateTime.now().toIso8601String().split('T')[0],
    );

    return vitals.map((vital) => vital.toMap()).toList();
  }

  /// Export symptoms
  Future<List<Map<String, dynamic>>> _exportSymptoms(int userId) async {
    final symptoms = await _symptomsDao.getSymptomsByDateRange(
      userId,
      DateTime(2000, 1, 1).toIso8601String().split('T')[0],
      DateTime.now().toIso8601String().split('T')[0],
    );

    return symptoms.map((symptom) => symptom.toMap()).toList();
  }

  /// Export daily summaries
  Future<List<Map<String, dynamic>>> _exportDailySummaries(int userId) async {
    final summaries = await _summaryDao.getDailySummariesByDateRange(
      userId,
      DateTime(2000, 1, 1).toIso8601String().split('T')[0],
      DateTime.now().toIso8601String().split('T')[0],
    );

    return summaries.map((summary) => summary.toMap()).toList();
  }

  /// Export medications
  Future<List<Map<String, dynamic>>> _exportMedications(int userId) async {
    final medications = await _medicationDao.getMedicationsByUserId(userId);
    return medications.map((med) => med.toMap()).toList();
  }

  /// Export as JSON string
  Future<String> exportAsJSON(int userId) async {
    final data = await exportUserData(userId);
    return jsonEncode(data);
  }

  /// Export daily summaries as CSV (for research/analysis)
  Future<String> exportDailySummariesAsCSV(int userId) async {
    final summaries = await _exportDailySummaries(userId);

    // CSV header
    final csvLines = <String>[
      'Date,Net Carbs (g),Protein (g),Fat (g),Calories,GKI,Weight (kg),In Ketosis,Energy Level,Mental Clarity',
    ];

    // CSV data rows
    for (final summary in summaries) {
      csvLines.add([
        summary['date'] ?? '',
        summary['total_net_carbs_g']?.toString() ?? '0',
        summary['total_protein_g']?.toString() ?? '0',
        summary['total_fat_g']?.toString() ?? '0',
        summary['total_energy_kcal']?.toString() ?? '0',
        summary['avg_gki_score']?.toString() ?? '',
        summary['weight_kg']?.toString() ?? '',
        (summary['in_ketosis'] == 1) ? 'Yes' : 'No',
        summary['avg_energy_level']?.toString() ?? '',
        summary['avg_mental_clarity']?.toString() ?? '',
      ].join(','));
    }

    return csvLines.join('\n');
  }

  /// Export diet entries as CSV
  Future<String> exportDietEntriesAsCSV(int userId) async {
    final entries = await _exportDietEntries(userId);

    final csvLines = <String>[
      'Date,Time,Food Description,Net Carbs (g),Protein (g),Fat (g),Calories,Meal Context',
    ];

    for (final entry in entries) {
      final dateTime = entry['recorded_at'] as String? ?? '';
      final date = dateTime.split('T')[0];
      final time = dateTime.contains('T') ? dateTime.split('T')[1].split('.')[0] : '';

      csvLines.add([
        date,
        time,
        entry['food_description']?.toString().replaceAll(',', ';') ?? '',
        entry['total_net_carbs_g']?.toString() ?? '0',
        entry['total_protein_g']?.toString() ?? '0',
        entry['total_fat_g']?.toString() ?? '0',
        entry['total_energy_kcal']?.toString() ?? '0',
        entry['meal_context']?.toString() ?? '',
      ].join(','));
    }

    return csvLines.join('\n');
  }

  /// Delete all user data (GDPR Right to Erasure)
  Future<void> deleteAllUserData(int userId) async {
    final db = await _dbService.database;

    await db.transaction((txn) async {
      // Delete user-created foods first (to avoid foreign key issues)
      await txn.delete(
        'tb_food',
        where: 'created_by_user_id = ?',
        whereArgs: [userId],
      );

      // Delete user (cascade will handle related records)
      await txn.delete(
        'tb_user',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
    });
  }

  /// Anonymize user data (for research purposes)
  Future<void> anonymizeUserData(int userId) async {
    final db = await _dbService.database;

    await db.transaction((txn) async {
      // Remove personally identifiable information
      await txn.update(
        'tb_user',
        {
          'email': 'anonymized_$userId@deleted.local',
          'full_name': null,
          'date_of_birth': null,
          'anonymous_id': null,
        },
        where: 'user_id = ?',
        whereArgs: [userId],
      );

      // Remove notes and photos
      await txn.update(
        'tb_diet_entries',
        {
          'notes': null,
          'food_photo_url': null,
        },
        where: 'user_id = ?',
        whereArgs: [userId],
      );

      await txn.update(
        'tb_health_log',
        {
          'notes': null,
        },
        where: 'user_id = ?',
        whereArgs: [userId],
      );
    });
  }
}

