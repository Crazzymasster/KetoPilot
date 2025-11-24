import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import '../drift_database_service.dart';
import '../drift_database.dart';
import '../models/user_model.dart';

/// User DAO using Drift (works on all platforms including web)
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

  /// Insert a new user
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

  /// Get user by ID
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

  /// Get user by email
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

  /// Get user by anonymous ID
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

  /// Update user
  Future<int> updateUser(UserModel user) async {
    try {
      final db = await _db;
      return await db.update(db.users).replace(
        UsersCompanion(
          userId: Value(user.userId!),
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
    } catch (e) {
      debugPrint('[USER DAO] ❌ Update error: $e');
      rethrow;
    }
  }

  /// Update last login timestamp
  Future<int> updateLastLogin(int userId) async {
    try {
      final db = await _db;
      return await (db.update(db.users)..where((u) => u.userId.equals(userId))).write(
        UsersCompanion(
          lastLogin: Value(DateTime.now().toIso8601String()),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
    } catch (e) {
      debugPrint('[USER DAO] ❌ Update last login error: $e');
      rethrow;
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

