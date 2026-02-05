import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

/// Security utilities for password hashing and encryption
class SecurityUtils {
  // Note: For production, use a proper bcrypt library like `bcrypt` package
  // This is a simplified version for demonstration

  /// Hash password (simplified - use bcrypt package in production)
  /// In production, use: bcrypt.hashpw(password, bcrypt.gensalt(rounds: 12))
  static String hashPassword(String password) {
    // This is a placeholder - use proper bcrypt in production
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// Verify password (simplified - use bcrypt package in production)
  /// In production, use: bcrypt.checkpw(password, passwordHash)
  static bool verifyPassword(String password, String passwordHash) {
    // This is a placeholder - use proper bcrypt in production
    final hashedPassword = hashPassword(password);
    return hashedPassword == passwordHash;
  }

  /// Generate anonymous ID (UUID)
  static String generateAnonymousId() {
    return const Uuid().v4();
  }

  /// Derive encryption key from password and device ID
  /// Note: This is a simplified version. In production, use proper key derivation (PBKDF2)
  /// Never store encryption key in code - derive from user password + device biometrics
  static String deriveEncryptionKey(String userPassword, String deviceId) {
    // Add salt for additional security
    final combined = '$userPassword:$deviceId:keto_pilot_salt_v1';
    final bytes = utf8.encode(combined);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// Generate a secure random token
  static String generateSecureToken() {
    return const Uuid().v4();
  }
}

