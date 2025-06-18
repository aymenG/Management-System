import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
Database? _database; // Make it nullable for initialization

Future<Database> getDatabase() async {
  if (_database != null) return _database!;

  // Get the path for the database
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, 'your_app_database.db');

  // Set the database factory for desktop
  databaseFactory = databaseFactoryFfi;

  _database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      // Define your tables here when the database is first created
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT UNIQUE,
          hashed_password TEXT
        )
      ''');
    },
  );
  return _database!;
}