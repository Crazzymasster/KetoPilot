import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/supabase_auth_service.dart';
import '../database/daos/drift_user_dao.dart';
import '../database/models/user_model.dart';
import '../services/supabase_service.dart';
import '../utils/password_utils.dart';

//global provider that keeps track of who's logged in
final userProvider = ChangeNotifierProvider<UserProvider>(
  (ref) => UserProvider(),
);

class UserProvider extends ChangeNotifier {
  final DriftUserDao _userDao = DriftUserDao();
  final SupabaseAuthService _authService = SupabaseAuthService();

  UserModel? _currentUser;
  User? _supabaseUser;
  bool _isLoading = true;

  UserModel? get currentUser => _currentUser;
  User? get supabaseUser => _supabaseUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _supabaseUser != null;
  int? get userId => _currentUser?.userId;
  String? get supabaseUserId => _supabaseUser?.id;
  bool get needsProfileCompletion {
    final user = _currentUser;
    if (user == null) return false;
    return user.dateOfBirth == null || user.gender == null;
  }

  UserProvider() {
    _loadUser();
    _setupAuthListener();
  }

  //listen to Supabase auth state changes
  void _setupAuthListener() {
    _authService.authStateChanges.listen((AuthState state) {
      final event = state.event;
      if (event == AuthChangeEvent.signedIn) {
        _supabaseUser = state.session?.user;
        _syncUserData();
        notifyListeners();
      } else if (event == AuthChangeEvent.signedOut) {
        _supabaseUser = null;
        _currentUser = null;
        notifyListeners();
      }
    });
  }

  //checks if someone was logged in last time the app closed
  Future<void> _loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check if user is logged in with Supabase
      _supabaseUser = _authService.currentUser;

      if (_supabaseUser != null) {
        // Load local user data if exists
        await _syncUserData();
      } else {
        // Fallback to local authentication (for backward compatibility)
        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt('current_user_id');

        if (userId != null) {
          _currentUser = await _userDao.getUserById(userId);
          if (_currentUser != null) {
            await _userDao.updateLastLogin(userId, DateTime.now());
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //sync user data between Supabase and local database (WITH FIX FOR UNIQUE CONSTRAINT)
  Future<void> _syncUserData() async {
    if (_supabaseUser == null) return;

    try {
      final metadata = _supabaseUser!.userMetadata ?? <String, dynamic>{};
      final metadataFullName = _stringFromMetadata(metadata, 'full_name');
      final metadataDateOfBirth = _stringFromMetadata(
        metadata,
        'date_of_birth',
      );
      final metadataGender = _stringFromMetadata(metadata, 'gender');
      final metadataHeight = _doubleFromMetadata(metadata, 'height_cm');
      final metadataWeight = _doubleFromMetadata(metadata, 'initial_weight_kg');
      final metadataTargetNetCarbs = _doubleFromMetadata(
        metadata,
        'target_net_carbs',
      );
      final metadataTargetProtein = _doubleFromMetadata(
        metadata,
        'target_protein',
      );
      final metadataTargetFat = _doubleFromMetadata(metadata, 'target_fat');
      final metadataTargetCalories = _doubleFromMetadata(
        metadata,
        'target_calories',
      );
      final metadataKetoStartDate = _stringFromMetadata(
        metadata,
        'keto_start_date',
      );

      // Try to find user by Supabase UUID (stored in anonymousId field)
      _currentUser = await _userDao.getUserByAnonymousId(_supabaseUser!.id);

      if (_currentUser == null) {
        // Create new local user profile if doesn't exist
        final newUser = UserModel(
          email: _supabaseUser!.email ?? '',
          passwordHash: '', // Not needed for Supabase auth
          fullName: metadataFullName,
          dateOfBirth: metadataDateOfBirth,
          gender: metadataGender,
          heightCm: metadataHeight,
          initialWeightKg: metadataWeight,
          targetNetCarbs: metadataTargetNetCarbs ?? 20.0,
          targetProtein: metadataTargetProtein,
          targetFat: metadataTargetFat,
          targetCalories: metadataTargetCalories,
          ketoStartDate: metadataKetoStartDate,
          emailVerified: _supabaseUser!.emailConfirmedAt != null ? 1 : 0,
          anonymousId: _supabaseUser!.id,
        );
        await _userDao.upsertUser(newUser);
        _currentUser = await _userDao.getUserByAnonymousId(_supabaseUser!.id);
      } else {
        // Update existing user's email verification status
        final updatedUser = _currentUser!.copyWith(
          emailVerified: _supabaseUser!.emailConfirmedAt != null ? 1 : 0,
        );
        await _userDao.updateUser(updatedUser);
        _currentUser = updatedUser;
      }
    } catch (e) {
      debugPrint('Error syncing user data: $e');
    }
  }

  //handles user login - returns null if successful, error message if not
  Future<String?> login(String email, String password) async {
    try {
      // Use Supabase authentication
      final result = await _authService.signIn(
        email: email,
        password: password,
      );

      if (!result.success) {
        return result.errorMessage;
      }

      _supabaseUser = result.user;
      await _syncUserData();

      // Update last login
      if (_currentUser?.userId != null) {
        await _userDao.updateLastLogin(_currentUser!.userId!, DateTime.now());
      }

      notifyListeners();
      return null; //null means success
    } catch (e) {
      debugPrint('Login error: $e');
      return 'An error occurred. Please try again.';
    }
  }

  //creates a new user account with Supabase
  Future<bool> register({
    required String email,
    required String password,
    String? fullName,
    Map<String, dynamic>? userMetadata,
  }) async {
    try {
      // Use Supabase authentication
      final result = await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        userMetadata: userMetadata,
      );

      if (!result.success) {
        debugPrint('Registration failed: ${result.errorMessage}');
        return false;
      }

      // Supabase will send verification email automatically
      // User will be synced to local DB when they verify and log in
      return true;
    } catch (e) {
      debugPrint('Registration error: $e');
      return false;
    }
  }

  //updates user profile info
  Future<bool> updateProfile(UserModel updatedUser) async {
    try {
      if (_supabaseUser != null) {
        await _updateSupabaseAuthUser(updatedUser);
        await _upsertSupabaseProfile(updatedUser);
      }
      await _userDao.updateUser(updatedUser);
      _currentUser = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Update profile error: $e');
      return false;
    }
  }

  Future<void> _updateSupabaseAuthUser(UserModel updatedUser) async {
    final client = SupabaseService().client;

    final metadata = <String, dynamic>{
      'full_name': updatedUser.fullName,
      'date_of_birth': updatedUser.dateOfBirth,
      'gender': updatedUser.gender,
      'height_cm': updatedUser.heightCm,
      'initial_weight_kg': updatedUser.initialWeightKg,
      'target_net_carbs': updatedUser.targetNetCarbs,
      'target_protein': updatedUser.targetProtein,
      'target_fat': updatedUser.targetFat,
      'target_calories': updatedUser.targetCalories,
      'keto_start_date': updatedUser.ketoStartDate,
      'medical_conditions': updatedUser.medicalConditions,
      'goals': updatedUser.goals,
      'iot_devices': updatedUser.iotDevices,
    };

    await client.auth.updateUser(UserAttributes(data: metadata));

    if (_supabaseUser != null && updatedUser.email != _supabaseUser!.email) {
      await client.auth.updateUser(UserAttributes(email: updatedUser.email));
    }
  }

  Future<void> _upsertSupabaseProfile(UserModel updatedUser) async {
    final client = SupabaseService().client;
    final payload = {
      'user_id': _supabaseUser!.id,
      'email': updatedUser.email,
      'full_name': updatedUser.fullName,
      'date_of_birth': updatedUser.dateOfBirth,
      'gender': updatedUser.gender,
      'height_cm': updatedUser.heightCm,
      'initial_weight_kg': updatedUser.initialWeightKg,
      'target_net_carbs': updatedUser.targetNetCarbs,
      'target_protein': updatedUser.targetProtein,
      'target_fat': updatedUser.targetFat,
      'target_calories': updatedUser.targetCalories,
      'keto_start_date': updatedUser.ketoStartDate,
      'medical_conditions': updatedUser.medicalConditions,
      'goals': updatedUser.goals,
      'iot_devices': updatedUser.iotDevices,
      'food_creation_count': updatedUser.foodCreationCount,
      'food_creation_window_start': updatedUser.foodCreationWindowStart,
      'max_foods_per_window': updatedUser.maxFoodsPerWindow,
      'window_duration_days': updatedUser.windowDurationDays,
      'research_consent': updatedUser.researchConsent,
      'data_sharing_consent': updatedUser.dataSharingConsent,
      'updated_at': DateTime.now().toIso8601String(),
    };

    await client.from('profiles').upsert(payload, onConflict: 'user_id');
  }

  //logs out and clears the session
  Future<void> logout() async {
    try {
      await _authService.signOut();
    } catch (e) {
      debugPrint('Logout error: $e');
    }

    _currentUser = null;
    _supabaseUser = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user_id');

    notifyListeners();
  }

  //reloads user data from the database
  Future<void> refreshUser() async {
    if (_currentUser?.userId == null) return;

    try {
      _currentUser = await _userDao.getUserById(_currentUser!.userId!);
      notifyListeners();
    } catch (e) {
      debugPrint('Refresh user error: $e');
    }
  }

  //checks if an email is already registered
  Future<bool> emailExists(String email) async {
    try {
      return await _userDao.emailExists(email);
    } catch (e) {
      debugPrint('Email exists check error: $e');
      return false;
    }
  }

  //marks a user's email as verified in the database
  Future<bool> markEmailVerified(int userId) async {
    try {
      final user = await _userDao.getUserById(userId);
      if (user == null) return false;

      final updatedUser = UserModel(
        userId: user.userId,
        email: user.email,
        passwordHash: user.passwordHash,
        emailVerified: 1,
        fullName: user.fullName,
        dateOfBirth: user.dateOfBirth,
        gender: user.gender,
        heightCm: user.heightCm,
        initialWeightKg: user.initialWeightKg,
        targetNetCarbs: user.targetNetCarbs,
        targetProtein: user.targetProtein,
        targetFat: user.targetFat,
        targetCalories: user.targetCalories,
        ketoStartDate: user.ketoStartDate,
        medicalConditions: user.medicalConditions,
        goals: user.goals,
        iotDevices: user.iotDevices,
        foodCreationCount: user.foodCreationCount,
        foodCreationWindowStart: user.foodCreationWindowStart,
        maxFoodsPerWindow: user.maxFoodsPerWindow,
        windowDurationDays: user.windowDurationDays,
        researchConsent: user.researchConsent,
        dataSharingConsent: user.dataSharingConsent,
        anonymousId: user.anonymousId,
        createdAt: user.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
        lastLogin: user.lastLogin,
      );

      await _userDao.updateUser(updatedUser);
      _currentUser = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Mark email verified error: $e');
      return false;
    }
  }

  String? _stringFromMetadata(Map<String, dynamic> metadata, String key) {
    final value = metadata[key];
    if (value == null) return null;
    return value.toString();
  }

  double? _doubleFromMetadata(Map<String, dynamic> metadata, String key) {
    final value = metadata[key];
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
