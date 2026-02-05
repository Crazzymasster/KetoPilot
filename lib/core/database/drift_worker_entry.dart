import 'package:drift/wasm.dart';

/// Entry point for Drift Web Worker
/// This file is compiled to drift_worker.dart.js using dart2js
void main() {
  WasmDatabase.workerMainForOpen();
}

