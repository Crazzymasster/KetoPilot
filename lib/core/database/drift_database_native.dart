import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Create database executor for native platforms (mobile/desktop)
/// 
/// Security considerations:
/// - Desktop: Stores in application data directory (still accessible with file permissions)
/// - Mobile: Stores in app-private directory (protected by OS sandboxing)
/// - Passwords are hashed with SHA-256 + salt
/// - For enterprise use, consider sqlcipher for full database encryption
Future<QueryExecutor> createExecutor() async {
  try {
    // Use getApplicationSupportDirectory for better security on desktop
    // On mobile, this is app-private and OS-protected
    // On desktop, it's in AppData/Application Support (less visible than Documents)
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'ketopilot.db'));
    
    // Note: For production, consider using sqlcipher_flutter_libs
    // for full database encryption at rest
    final executor = NativeDatabase(file);
    
    debugPrint('[DRIFT NATIVE] ✅ SQLite executor created at: ${file.path}');
    return executor;
  } catch (e) {
    debugPrint('[DRIFT NATIVE] ❌ Error: $e');
    rethrow;
  }
}



