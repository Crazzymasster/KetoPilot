import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/daos/drift_user_dao.dart';
import '../database/models/user_model.dart';
import '../utils/password_utils.dart';

//global provider that keeps track of who's logged in
final userProvider = ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

class UserProvider extends ChangeNotifier {
  final DriftUserDao _userDao = DriftUserDao();
  UserModel? _currentUser;
  bool _isLoading = true;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  int? get userId => _currentUser?.userId;

  UserProvider() {
    _loadUser();
  }

  //checks if someone was logged in last time the app closed
  Future<void> _loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('current_user_id');
      
      if (userId != null) {
        _currentUser = await _userDao.getUserById(userId);
        if (_currentUser != null) {
          await _userDao.updateLastLogin(userId, DateTime.now());
        }
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //handles user login - returns null if successful, error message if not
  Future<String?> login(String email, String password) async {
    try {
      final user = await _userDao.getUserByEmail(email);
      
      if (user == null) {
        return 'Invalid email or password';
      }

      //check if the password matches using secure hashing
      if (!PasswordUtils.verifyPassword(password, user.passwordHash)) {
        return 'Invalid email or password';
      }

      //make sure their email is verified before letting them in
      if (user.emailVerified != 1) {
        return 'Please verify your email before logging in. Check your inbox for the verification code.';
      }

      _currentUser = user;
      
      //remember them for next time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('current_user_id', user.userId!);
      
      await _userDao.updateLastLogin(user.userId!, DateTime.now());
      
      notifyListeners();
      return null; //null means success
    } catch (e) {
      debugPrint('Login error: $e');
      return 'An error occurred. Please try again.';
    }
  }

  //creates a new user account (only called after email verification)
  Future<bool> register({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      if (await _userDao.emailExists(email)) {
        return false;
      }

      //hash the password before storing it
      final hashedPassword = PasswordUtils.hashPassword(password);
      final newUser = UserModel(
        email: email,
        passwordHash: hashedPassword,
        fullName: fullName,
        emailVerified: 1, //email is already verified by this point
      );

      final userId = await _userDao.insertUser(newUser);
      
      _currentUser = await _userDao.getUserById(userId);
      
      //save their session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('current_user_id', userId);
      
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Registration error: $e');
      return false;
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
