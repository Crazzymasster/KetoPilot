import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../constants/app_constants.dart';
import 'database_schema.dart';

/// Main database service for Keto Pilot
/// Handles database initialization, connection, and migration
/// Works on mobile platforms. On web, returns a mock database.
class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;
  static final bool _isWeb = kIsWeb;

  DatabaseService._internal();

  factory DatabaseService() {
    _instance ??= DatabaseService._internal();
    return _instance!;
  }

  /// Check if running on web
  bool get isWeb => _isWeb;

  /// Get database instance (singleton)
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    // On web, sqflite doesn't work - return a mock or throw
    if (_isWeb) {
      throw UnsupportedError(
        'sqflite is not supported on web. '
        'Please use a web-compatible storage solution like IndexedDB, '
        'or use a package like drift (formerly Moor) that supports web.'
      );
    }
    
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database (mobile only)
  Future<Database> _initDatabase() async {
    if (_isWeb) {
      throw UnsupportedError('Database initialization not supported on web');
    }
    
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  }

  /// Create database schema
  Future<void> _onCreate(Database db, int version) async {
    await DatabaseSchema.createTables(db);
    await DatabaseSchema.createIndexes(db);
    await DatabaseSchema.createTriggers(db);
    await DatabaseSchema.createFtsTables(db);
  }

  /// Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Migration logic will be added here as schema evolves
    if (oldVersion < newVersion) {
      // Example: Add new columns or tables
      // await db.execute('ALTER TABLE tb_user ADD COLUMN new_field TEXT');
    }
  }

  /// Database opened callback
  Future<void> _onOpen(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Close database connection
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Delete database (for testing/reset)
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}

