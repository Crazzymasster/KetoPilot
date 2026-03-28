import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import '../drift_database_service.dart';
import '../drift_database.dart';
import '../models/symptoms_model.dart';

//handles all symptoms database operations using Drift
//replaces sqflite SymptomsDao for cross-platform support
class DriftSymptomsDao {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  Future<AppDatabase> get _db async {
    try {
      return await _dbService.database;
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Error: $e');
      rethrow;
    }
  }

  //insert a new symptoms entry
  Future<int> insertSymptoms(SymptomsModel symptoms) async {
    try {
      final db = await _db;
      final id = await db.into(db.symptoms).insert(
        SymptomsCompanion(
          userId: Value(symptoms.userId),
          recordedAt: Value(symptoms.recordedAt),
          date: Value(symptoms.date),
          headacheSeverity: Value(symptoms.headacheSeverity),
          fatigueSeverity: Value(symptoms.fatigueSeverity),
          nauseaSeverity: Value(symptoms.nauseaSeverity),
          dizzinessSeverity: Value(symptoms.dizzinessSeverity),
          brainFogSeverity: Value(symptoms.brainFogSeverity),
          irritabilitySeverity: Value(symptoms.irritabilitySeverity),
          muscleCrampsSeverity: Value(symptoms.muscleCrampsSeverity),
          energyLevel: Value(symptoms.energyLevel),
          mentalClarity: Value(symptoms.mentalClarity),
          moodRating: Value(symptoms.moodRating),
          sleepQuality: Value(symptoms.sleepQuality),
          hungerLevel: Value(symptoms.hungerLevel),
          satietyLevel: Value(symptoms.satietyLevel),
          bloatingSeverity: Value(symptoms.bloatingSeverity),
          digestionQuality: Value(symptoms.digestionQuality),
          customSymptoms: Value(symptoms.customSymptoms),
          additionalNotes: Value(symptoms.additionalNotes),
          synced: Value(symptoms.synced),
        ),
      );
      debugPrint('[SYMPTOMS DAO] ✓ Inserted symptom log ID: $id');
      return id;
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Insert error: $e');
      rethrow;
    }
  }

  //get symptoms by ID
  Future<SymptomsModel?> getSymptomsById(int symptomId) async {
    try {
      final db = await _db;
      final query = db.select(db.symptoms)
        ..where((s) => s.symptomId.equals(symptomId));
      final result = await query.getSingleOrNull();
      return result != null ? _symptomsFromDrift(result) : null;
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Get by ID error: $e');
      rethrow;
    }
  }

  //get symptoms for a user on a specific date
  Future<List<SymptomsModel>> getSymptomsByDate(int userId, String date) async {
    try {
      final db = await _db;
      final query = db.select(db.symptoms)
        ..where((s) => s.userId.equals(userId) & s.date.equals(date))
        ..orderBy([(s) => OrderingTerm(expression: s.recordedAt)]);
      final results = await query.get();
      return results.map(_symptomsFromDrift).toList();
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Get by date error: $e');
      rethrow;
    }
  }

  //get symptoms for a user within a date range
  Future<List<SymptomsModel>> getSymptomsByDateRange(
    int userId,
    String startDate,
    String endDate,
  ) async {
    try {
      final db = await _db;
      final query = db.select(db.symptoms)
        ..where((s) =>
            s.userId.equals(userId) &
            s.date.isBiggerOrEqualValue(startDate) &
            s.date.isSmallerOrEqualValue(endDate))
        ..orderBy([(s) => OrderingTerm(expression: s.recordedAt)]);
      final results = await query.get();
      return results.map(_symptomsFromDrift).toList();
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Get by date range error: $e');
      rethrow;
    }
  }

  //get last 7 days of symptom logs (for weekly graph)
  Future<List<SymptomsModel>> getLast7DaysSymptoms(
    int userId,
    String endDate,
    String startDate,
  ) async {
    try {
      final db = await _db;
      final query = db.select(db.symptoms)
        ..where((s) =>
            s.userId.equals(userId) &
            s.date.isBiggerOrEqualValue(startDate) &
            s.date.isSmallerOrEqualValue(endDate))
        ..orderBy([(s) => OrderingTerm(expression: s.date)]);
      final results = await query.get();
      return results.map(_symptomsFromDrift).toList();
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Get last 7 days error: $e');
      rethrow;
    }
  }

  //update symptoms
  Future<void> updateSymptoms(SymptomsModel symptoms) async {
    try {
      final db = await _db;
      await (db.update(db.symptoms)
            ..where((s) => s.symptomId.equals(symptoms.symptomId!)))
          .write(SymptomsCompanion(
        headacheSeverity: Value(symptoms.headacheSeverity),
        fatigueSeverity: Value(symptoms.fatigueSeverity),
        nauseaSeverity: Value(symptoms.nauseaSeverity),
        dizzinessSeverity: Value(symptoms.dizzinessSeverity),
        brainFogSeverity: Value(symptoms.brainFogSeverity),
        irritabilitySeverity: Value(symptoms.irritabilitySeverity),
        muscleCrampsSeverity: Value(symptoms.muscleCrampsSeverity),
        energyLevel: Value(symptoms.energyLevel),
        mentalClarity: Value(symptoms.mentalClarity),
        moodRating: Value(symptoms.moodRating),
        sleepQuality: Value(symptoms.sleepQuality),
        hungerLevel: Value(symptoms.hungerLevel),
        satietyLevel: Value(symptoms.satietyLevel),
        bloatingSeverity: Value(symptoms.bloatingSeverity),
        digestionQuality: Value(symptoms.digestionQuality),
        customSymptoms: Value(symptoms.customSymptoms),
        additionalNotes: Value(symptoms.additionalNotes),
      ));
      debugPrint('[SYMPTOMS DAO] ✓ Updated symptom log ID: ${symptoms.symptomId}');
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Update error: $e');
      rethrow;
    }
  }

  //delete symptoms
  Future<void> deleteSymptoms(int symptomId) async {
    try {
      final db = await _db;
      await (db.delete(db.symptoms)..where((s) => s.symptomId.equals(symptomId)))
          .go();
      debugPrint('[SYMPTOMS DAO] ✓ Deleted symptom log ID: $symptomId');
    } catch (e) {
      debugPrint('[SYMPTOMS DAO] ❌ Delete error: $e');
      rethrow;
    }
  }

  //convert Drift Symptom row to SymptomsModel
  SymptomsModel _symptomsFromDrift(Symptom row) {
    return SymptomsModel(
      symptomId: row.symptomId,
      userId: row.userId,
      recordedAt: row.recordedAt,
      date: row.date,
      headacheSeverity: row.headacheSeverity,
      fatigueSeverity: row.fatigueSeverity,
      nauseaSeverity: row.nauseaSeverity,
      dizzinessSeverity: row.dizzinessSeverity,
      brainFogSeverity: row.brainFogSeverity,
      irritabilitySeverity: row.irritabilitySeverity,
      muscleCrampsSeverity: row.muscleCrampsSeverity,
      energyLevel: row.energyLevel,
      mentalClarity: row.mentalClarity,
      moodRating: row.moodRating,
      sleepQuality: row.sleepQuality,
      hungerLevel: row.hungerLevel,
      satietyLevel: row.satietyLevel,
      bloatingSeverity: row.bloatingSeverity,
      digestionQuality: row.digestionQuality,
      customSymptoms: row.customSymptoms,
      additionalNotes: row.additionalNotes,
      synced: row.synced,
      createdAt: row.createdAt,
    );
  }
}
