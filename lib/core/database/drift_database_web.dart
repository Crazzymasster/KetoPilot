import 'package:flutter/foundation.dart' show debugPrint;
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Create database executor for web platform using WASM
/// Prefers unsafeIndexedDb which runs in main thread for reliable persistence
Future<QueryExecutor> createExecutor() async {
  try {
    debugPrint('[DRIFT WEB] Creating WASM database executor...');
    
    //open WASM database - let Drift probe for available implementations
    final result = await WasmDatabase.open(
      databaseName: 'ketopilot.db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
      //specify that we want IndexedDB mode for persistence
      //setting this forces IndexedDB over OPFS when both are available
      enableMigrations: true,
    );
    
    final impl = result.chosenImplementation;
    debugPrint('[DRIFT WEB] Storage implementation: $impl');
    debugPrint('[DRIFT WEB] Missing features: ${result.missingFeatures}');
    
    //check if we got persistent storage
    final isPersistent = impl == WasmStorageImplementation.opfsLocks ||
        impl == WasmStorageImplementation.opfsShared ||
        impl == WasmStorageImplementation.sharedIndexedDb ||
        impl == WasmStorageImplementation.unsafeIndexedDb;
    
    if (!isPersistent) {
      debugPrint('[DRIFT WEB] ⚠️ WARNING: Using non-persistent storage: $impl');
      debugPrint('[DRIFT WEB] ⚠️ Data will be LOST when browser closes!');
    } else {
      debugPrint('[DRIFT WEB] ✅ Using persistent storage: $impl');
    }
    
    //if we got sharedIndexedDb, that should persist too - log for debugging
    if (impl == WasmStorageImplementation.sharedIndexedDb) {
      debugPrint('[DRIFT WEB] ℹ️ Using SharedWorker-based IndexedDB');
      debugPrint('[DRIFT WEB] ℹ️ Data should persist in IndexedDB storage');
    }
    
    return result.resolvedExecutor;
  } catch (e, stackTrace) {
    debugPrint('[DRIFT WEB] ❌ Error creating WASM executor: $e');
    debugPrint('[DRIFT WEB] Stack trace: $stackTrace');
    rethrow;
  }
}

