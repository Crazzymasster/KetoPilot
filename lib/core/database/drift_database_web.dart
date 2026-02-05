import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Create database executor for web platform using WASM
/// Uses WebAssembly for better performance and compatibility
/// Note: Uses WasmDatabase.open() which handles WASM loading automatically
Future<QueryExecutor> createExecutor() async {
  try {
    debugPrint('[DRIFT WEB] Creating WASM database executor...');
    
    // Open WASM database
    // Note: If local files cause "dispatch_xFunc" errors, they may be incompatible
    // Try local files first, but they must be from matching Drift/sqlite3.dart releases
    final result = await WasmDatabase.open(
      databaseName: 'ketopilot.db',
      // Try local file first
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      // Try local worker first  
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );
    
    debugPrint('[DRIFT WEB] ✅ WASM database opened');
    
    // Log any missing features (for debugging)
    if (result.missingFeatures.isNotEmpty) {
      debugPrint('[DRIFT WEB] ⚠️ Missing features: ${result.missingFeatures}');
      debugPrint('[DRIFT WEB] Using implementation: ${result.chosenImplementation}');
    }
    
    // Return the resolved executor
    return result.resolvedExecutor;
  } catch (e, stackTrace) {
    debugPrint('[DRIFT WEB] ❌ Error creating WASM executor: $e');
    debugPrint('[DRIFT WEB] Stack trace: $stackTrace');
    rethrow;
  }
}

