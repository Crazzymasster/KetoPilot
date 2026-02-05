import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import '../drift_database_service.dart';
import '../drift_database.dart';
import '../models/user_model.dart';

//handles all user database operations using Drift
class DriftUserDao {
  final DriftDatabaseService _dbService = DriftDatabaseService();

  Future<AppDatabase> get _db async {
    try {
      return await _dbService.database;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Error: $e');
      rethrow;
    }
  }

  //adds a new user to the database
  Future<int> insertUser(UserModel user) async {
    try {
      final db = await _db;
      final id = await db.into(db.users).insert(
        UsersCompanion(
          email: Value(user.email),
          passwordHash: Value(user.passwordHash),
          emailVerified: Value(user.emailVerified),
          fullName: Value(user.fullName),
          dateOfBirth: Value(user.dateOfBirth),
          gender: Value(user.gender),
          heightCm: Value(user.heightCm),
          initialWeightKg: Value(user.initialWeightKg),
          targetNetCarbs: Value(user.targetNetCarbs),
          targetProtein: Value(user.targetProtein),
          targetFat: Value(user.targetFat),
          targetCalories: Value(user.targetCalories),
          ketoStartDate: Value(user.ketoStartDate),
          medicalConditions: Value(user.medicalConditions),
          goals: Value(user.goals),
          iotDevices: Value(user.iotDevices),
          foodCreationCount: Value(user.foodCreationCount),
          foodCreationWindowStart: Value(user.foodCreationWindowStart),
          maxFoodsPerWindow: Value(user.maxFoodsPerWindow),
          windowDurationDays: Value(user.windowDurationDays),
          researchConsent: Value(user.researchConsent),
          dataSharingConsent: Value(user.dataSharingConsent),
          anonymousId: Value(user.anonymousId),
          lastLogin: Value(user.lastLogin),
        ),
      );
      return id;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Insert error: $e');
      rethrow;
    }
  }

  //finds a user by their ID
  Future<UserModel?> getUserById(int userId) async {
    try {
      final db = await _db;
      final query = db.select(db.users)..where((u) => u.userId.equals(userId));
      final result = await query.getSingleOrNull();
      return result != null ? _userFromDrift(result) : null;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Get error: $e');
      rethrow;
    }
  }

  //finds a user by their email address
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final db = await _db;
      final query = db.select(db.users)..where((u) => u.email.equals(email));
      final result = await query.getSingleOrNull();
      return result != null ? _userFromDrift(result) : null;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Get by email error: $e');
      rethrow;
    }
  }

  //finds a user by their anonymous ID (for research)
  Future<UserModel?> getUserByAnonymousId(String anonymousId) async {
    try {
      final db = await _db;
      final query = db.select(db.users)..where((u) => u.anonymousId.equals(anonymousId));
      final result = await query.getSingleOrNull();
      return result != null ? _userFromDrift(result) : null;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Get by anonymous ID error: $e');
      rethrow;
    }
  }

  //updates an existing user's info
  Future<int> updateUser(UserModel user) async {
    try {
      if (user.userId == null) {
        throw ArgumentError('User ID is required for update');
      }
      final db = await _db;
      final updated = await (db.update(db.users)
            ..where((u) => u.userId.equals(user.userId!)))
          .write(
        UsersCompanion(
          email: Value(user.email),
          passwordHash: Value(user.passwordHash),
          emailVerified: Value(user.emailVerified),
          fullName: Value(user.fullName),
          dateOfBirth: Value(user.dateOfBirth),
          gender: Value(user.gender),
          heightCm: Value(user.heightCm),
          initialWeightKg: Value(user.initialWeightKg),
          targetNetCarbs: Value(user.targetNetCarbs),
          targetProtein: Value(user.targetProtein),
          targetFat: Value(user.targetFat),
          targetCalories: Value(user.targetCalories),
          ketoStartDate: Value(user.ketoStartDate),
          medicalConditions: Value(user.medicalConditions),
          goals: Value(user.goals),
          iotDevices: Value(user.iotDevices),
          foodCreationCount: Value(user.foodCreationCount),
          foodCreationWindowStart: Value(user.foodCreationWindowStart),
          maxFoodsPerWindow: Value(user.maxFoodsPerWindow),
          windowDurationDays: Value(user.windowDurationDays),
          researchConsent: Value(user.researchConsent),
          dataSharingConsent: Value(user.dataSharingConsent),
          anonymousId: Value(user.anonymousId),
          updatedAt: Value(DateTime.now().toIso8601String()),
          lastLogin: Value(user.lastLogin),
        ),
      );
      return updated;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Update error: $e');
      rethrow;
    }
  }

  //records when someone last logged in
  Future<int> updateLastLogin(int userId, DateTime loginTime) async {
    try {
      final db = await _db;
      return await (db.update(db.users)..where((u) => u.userId.equals(userId))).write(
        UsersCompanion(
          lastLogin: Value(loginTime.toIso8601String()),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
    } catch (e) {
      debugPrint('[USER DAO] ❌ Update last login error: $e');
      rethrow;
    }
  }

  //checks if an email is already registered
  Future<bool> emailExists(String email) async {
    try {
      final db = await _db;
      final query = db.select(db.users)..where((u) => u.email.equals(email));
      final result = await query.getSingleOrNull();
      return result != null;
    } catch (e) {
      debugPrint('[USER DAO] ❌ Email exists check error: $e');
      return false;
    }
  }

  UserModel _userFromDrift(User row) {
    return UserModel(
      userId: row.userId,
      email: row.email,
      passwordHash: row.passwordHash,
      emailVerified: row.emailVerified,
      fullName: row.fullName,
      dateOfBirth: row.dateOfBirth,
      gender: row.gender,
      heightCm: row.heightCm,
      initialWeightKg: row.initialWeightKg,
      targetNetCarbs: row.targetNetCarbs,
      targetProtein: row.targetProtein,
      targetFat: row.targetFat,
      targetCalories: row.targetCalories,
      ketoStartDate: row.ketoStartDate,
      medicalConditions: row.medicalConditions,
      goals: row.goals,
      iotDevices: row.iotDevices,
      foodCreationCount: row.foodCreationCount,
      foodCreationWindowStart: row.foodCreationWindowStart,
      maxFoodsPerWindow: row.maxFoodsPerWindow,
      windowDurationDays: row.windowDurationDays,
      researchConsent: row.researchConsent,
      dataSharingConsent: row.dataSharingConsent,
      anonymousId: row.anonymousId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      lastLogin: row.lastLogin,
    );
  }
}

