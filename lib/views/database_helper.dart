import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database; // Make it nullable for initialization
  static const String tableName = 'users'; // Define table name as a constant

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Set the database factory for desktop
    databaseFactory = databaseFactoryFfi;

    _database = await openDatabase(
      await _getDatabasePath(), // Use a helper for the path
      version: 1,
      onCreate: (db, version) async {
        // Define your tables here when the database is first created
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            hashed_password TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database upgrades here if your schema changes
        // For example, if you add new columns in a future version:
        // if (oldVersion < 2) {
        //   await db.execute("ALTER TABLE $tableName ADD COLUMN new_column TEXT;");
        // }
      },
    );
    return _database!;
  }

  // Helper to get the database path
  Future<String> _getDatabasePath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'your_app_database.db');
    return path;
  }

  // --- New method to insert a user ---
  Future<int> insertUser(String username, String hashedPassword) async {
    final db = await database; // Get the database instance
    return await db.insert(
      tableName,
      {'username': username, 'hashed_password': hashedPassword},
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Replace if username exists
    );
  }

  // --- Optional: Method to query a user by username for login verification ---
  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      tableName,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1, // Only expect one user per username
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null; // User not found
  }
}
