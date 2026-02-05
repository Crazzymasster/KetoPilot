import 'package:flutter/foundation.dart' show debugPrint;
import '../database/models/food_model.dart';
import '../database/models/user_model.dart';
import '../database/daos/drift_food_dao.dart';
import '../database/daos/drift_user_dao.dart';
import '../database/daos/food_creation_audit_dao.dart';

/// Service for handling food creation with rate limiting
/// Uses Drift DAOs for cross-platform compatibility
class FoodCreationService {
  final DriftFoodDao _foodDao = DriftFoodDao();
  final DriftUserDao _userDao = DriftUserDao();
  // Note: FoodCreationAuditDao still uses sqflite - will be migrated later
  final FoodCreationAuditDao? _auditDao = null; // Temporarily disabled during migration

  /// Check if user can create food (rate limiting)
  /// If user doesn't exist, creates a default user and allows creation
  Future<FoodCreationResult> canCreateFood(int userId) async {
    var user = await _userDao.getUserById(userId);
    
    // If user doesn't exist, create a default user
    if (user == null) {
      debugPrint('[FOOD CREATION] User $userId not found, creating default user...');
      final defaultUser = UserModel(
        email: 'user$userId@ketopilot.local',
        passwordHash: 'default_hash', // Placeholder - should be replaced with proper auth
        fullName: 'Default User',
        targetNetCarbs: 20.0,
        maxFoodsPerWindow: 50,
        windowDurationDays: 21,
      );
      final newUserId = await _userDao.insertUser(defaultUser);
      user = await _userDao.getUserById(newUserId);
      if (user == null) {
        // If still null after creation, return default allowed result
        debugPrint('[FOOD CREATION] ⚠️ Failed to create user, allowing creation anyway');
        final now = DateTime.now();
        return FoodCreationResult(
          canCreate: true,
          remainingQuota: 50,
          resetDate: now.add(const Duration(days: 21)).toIso8601String().split('T')[0],
        );
      }
      debugPrint('[FOOD CREATION] ✅ Created default user with ID: $newUserId');
    }

    final now = DateTime.now();
    final windowStart = user.foodCreationWindowStart != null
        ? DateTime.parse(user.foodCreationWindowStart!)
        : now;

    // Check if window has expired
    final daysSinceWindowStart = now.difference(windowStart).inDays;
    final windowExpired = daysSinceWindowStart > user.windowDurationDays;

    if (windowExpired) {
      // Reset window
      await _userDao.updateUser(user.copyWith(
        foodCreationCount: 0,
        foodCreationWindowStart: now.toIso8601String(),
      ));
      return FoodCreationResult(
        canCreate: true,
        remainingQuota: user.maxFoodsPerWindow,
        resetDate: now.add(Duration(days: user.windowDurationDays)).toIso8601String().split('T')[0],
      );
    }

    // Check if limit exceeded
    final remainingQuota = user.maxFoodsPerWindow - user.foodCreationCount;
    if (remainingQuota <= 0) {
      final resetDate = windowStart
          .add(Duration(days: user.windowDurationDays))
          .toIso8601String()
          .split('T')[0];
      return FoodCreationResult(
        canCreate: false,
        remainingQuota: 0,
        resetDate: resetDate,
        error: 'Food creation limit exceeded',
      );
    }

    return FoodCreationResult(
      canCreate: true,
      remainingQuota: remainingQuota,
      resetDate: windowStart
          .add(Duration(days: user.windowDurationDays))
          .toIso8601String()
          .split('T')[0],
    );
  }

  /// Create food with rate limiting check
  Future<int> createFood({
    required FoodModel food,
    required int userId,
  }) async {
    // Check rate limit
    final result = await canCreateFood(userId);
    if (!result.canCreate) {
      throw FoodCreationLimitException(
        message: result.error ?? 'Food creation limit exceeded',
        limit: await _getUserLimit(userId),
        windowDays: await _getUserWindowDays(userId),
        resetDate: result.resetDate,
      );
    }

    // Create food with user ID
    final foodWithUser = FoodModel(
      foodId: food.foodId,
      keylist: food.keylist,
      foodDescription: food.foodDescription,
      source: food.source,
      createdByUserId: userId,
      isVerified: food.isVerified,
      isKetoFriendly: food.isKetoFriendly,
      energyKcal: food.energyKcal,
      totalProteinG: food.totalProteinG,
      totalFatG: food.totalFatG,
      totalCarbohydrateG: food.totalCarbohydrateG,
      dietaryFiberG: food.dietaryFiberG,
      sugarG: food.sugarG,
      addedSugarG: food.addedSugarG,
      netCarbsG: food.netCarbsG,
      saturatedFatG: food.saturatedFatG,
      monounsaturatedFatG: food.monounsaturatedFatG,
      polyunsaturatedFatG: food.polyunsaturatedFatG,
      transFatG: food.transFatG,
      cholesterolMg: food.cholesterolMg,
      sodiumMg: food.sodiumMg,
      potassiumMg: food.potassiumMg,
      magnesiumMg: food.magnesiumMg,
      calciumMg: food.calciumMg,
      glycemicIndex: food.glycemicIndex,
      glycemicLoad: food.glycemicLoad,
      vitamins: food.vitamins,
      minerals: food.minerals,
      foodPhotoUrl: food.foodPhotoUrl,
      barcode: food.barcode,
      createdAt: food.createdAt,
      updatedAt: food.updatedAt,
    );
           // Use DriftFoodDao for all platforms
           final foodId = await _foodDao.insertFood(foodWithUser);

    // The trigger will automatically increment the counter and create audit record
    // Note: Audit functionality may not work on web (uses sqflite-based DAO)
    // For web, food creation works but audit tracking is limited

    return foodId;
  }

  Future<int> _getUserLimit(int userId) async {
    final user = await _userDao.getUserById(userId);
    return user?.maxFoodsPerWindow ?? 50;
  }

  Future<int> _getUserWindowDays(int userId) async {
    final user = await _userDao.getUserById(userId);
    return user?.windowDurationDays ?? 21;
  }
}

/// Result of food creation rate limit check
class FoodCreationResult {
  final bool canCreate;
  final int remainingQuota;
  final String resetDate;
  final String? error;

  FoodCreationResult({
    required this.canCreate,
    required this.remainingQuota,
    required this.resetDate,
    this.error,
  });
}

/// Exception thrown when food creation limit is exceeded
class FoodCreationLimitException implements Exception {
  final String message;
  final int limit;
  final int windowDays;
  final String resetDate;

  FoodCreationLimitException({
    required this.message,
    required this.limit,
    required this.windowDays,
    required this.resetDate,
  });

  @override
  String toString() => message;
}

