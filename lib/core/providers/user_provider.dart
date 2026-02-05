import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/supabase_auth_service.dart';
import '../database/daos/drift_user_dao.dart';
import '../database/models/user_model.dart';
import '../utils/password_utils.dart';

//global provider that keeps track of who's logged in
final userProvider = ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

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

  //sync user data between Supabase and local database
  Future<void> _syncUserData() async {
    if (_supabaseUser == null) return;

    try {
      // Try to find user by Supabase UUID (stored in anonymousId field)
      _currentUser = await _userDao.getUserByAnonymousId(_supabaseUser!.id);

      if (_currentUser == null) {
        // Create new local user profile if doesn't exist
        final newUser = UserModel(
          email: _supabaseUser!.email ?? '',
          passwordHash: '', // Not needed for Supabase auth
          fullName: _supabaseUser!.userMetadata?['full_name'],
          emailVerified: _supabaseUser!.emailConfirmedAt != null ? 1 : 0,
          anonymousId: _supabaseUser!.id,
        );
        
        final userId = await _userDao.insertUser(newUser);
        _currentUser = await _userDao.getUserById(userId);
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

  //creates a new user account
  Future<String?> register({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      // Use Supabase authentication
      final result = await _authService.signUp(
        email: email,
        password: password,
        metadata: fullName != null ? {'full_name': fullName} : null,
      );

      if (!result.success) {
        return result.errorMessage;
      }

      _supabaseUser = result.user;
      
      // Create local user profile
      final newUser = UserModel(
        email: email,
        passwordHash: '', // Not needed for Supabase auth
        fullName: fullName,
        emailVerified: _supabaseUser?.emailConfirmedAt != null ? 1 : 0,
        anonymousId: _supabaseUser?.id,
      );

      final userId = await _userDao.insertUser(newUser);
      _currentUser = await _userDao.getUserById(userId);
      
      notifyListeners();
      return null; // Success
    } catch (e) {
      debugPrint('Registration error: $e');
      return 'An error occurred during registration. Please try again.';
    }
  }

  //updates user profile info
  Future<bool> updateProfile(UserModel updatedUser) async {
    try {
      await _userDao.updateUser(updatedUser);
      _currentUser = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Update profile error: $e');
      return false;
    }
  }

  //logs out and clears the session
  Future<void> logout() async {
    // Sign out from Supabase
    await _authService.signOut();
    
    _supabaseUser = null;
    _currentUser = null;
    
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
}
