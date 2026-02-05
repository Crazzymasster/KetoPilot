import 'dart:convert';
import 'package:crypto/crypto.dart';

//handles password hashing and verification with SHA-256 + salt
class PasswordUtils {
  //takes a password and returns a hashed version that's safe to store
  //the hash includes a unique salt so even identical passwords look different
  static String hashPassword(String password, [String? salt]) {
    salt ??= _generateSalt();
    
    final saltedPassword = '$password:$salt';
    final bytes = utf8.encode(saltedPassword);
    final hash = sha256.convert(bytes);
    
    //storing both salt and hash together so we can verify logins later
    return '$salt:${hash.toString()}';
  }

  //checks if a password matches the stored hash
  static bool verifyPassword(String password, String storedHash) {
    try {
      //split the stored hash to get the salt
      final parts = storedHash.split(':');
      if (parts.length != 2) {
        return false;
      }
      
      final salt = parts[0];
      final hash = parts[1];
      
      //hash the login password with the same salt and compare
      final saltedPassword = '$password:$salt';
      final bytes = utf8.encode(saltedPassword);
      final computedHash = sha256.convert(bytes).toString();
      
      return computedHash == hash;
    } catch (e) {
      return false;
    }
  }

  //creates a random salt using timestamps
  static String _generateSalt() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final random = DateTime.now().microsecondsSinceEpoch.toString();
    return sha256.convert(utf8.encode('$timestamp:$random')).toString().substring(0, 16);
  }

  //checks if password meets our minimum requirements
  static bool isStrongPassword(String password) {
    if (password.length < 5) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    
    return true;
  }

  //returns a list of what's missing from the password
  static List<String> getPasswordRequirements(String password) {
    final requirements = <String>[];
    
    if (password.length < 5) {
      requirements.add('At least 5 characters');
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      requirements.add('At least one capital letter');
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      requirements.add('At least one number');
    }
    
    return requirements;
  }
}
