import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import '../../lib/core/database/database_schema.dart';

/// Helper for setting up test databases
class TestDatabaseHelper {
  static Future<Database> createTestDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    return await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        // Disable foreign keys for testing to avoid constraint issues
        await db.execute('PRAGMA foreign_keys = OFF');
        await DatabaseSchema.createTables(db);
        await DatabaseSchema.createFtsTables(db);
        await DatabaseSchema.createIndexes(db);
        await DatabaseSchema.createTriggers(db);
        // Re-enable foreign keys after setup
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  static Future<void> closeDatabase(Database db) async {
    await db.close();
  }
}

