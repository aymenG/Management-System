import 'package:management_system/models/car.dart';
import 'package:management_system/models/rental.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../controllers/my_scripts.dart';

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
        // Users table (already exists)
        await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE,
      hashed_password TEXT,
      role TEXT DEFAULT 'user'
    )
  ''');
        await insertInitialUsers(db);

        // Cars table
        await db.execute('''
CREATE TABLE cars (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  brand TEXT NOT NULL,
  model TEXT NOT NULL,
  year INTEGER NOT NULL,
  plate_number TEXT UNIQUE NOT NULL,
  daily_price REAL,
  image_path TEXT,
  status TEXT DEFAULT 'available'
);


  ''');

        // Customers table
        await db.execute('''
    CREATE TABLE customers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      full_name TEXT NOT NULL,
      phone TEXT,
      email TEXT
    )
  ''');

        // Rentals table
        await db.execute('''
CREATE TABLE rentals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_name TEXT NOT NULL,
  car_id INTEGER NOT NULL,
  rent_date TEXT NOT NULL,
  return_date TEXT,
  total_price REAL
)

  ''');

        // Payments table (optional)
        await db.execute('''
    CREATE TABLE payments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      rental_id INTEGER NOT NULL,
      amount_paid REAL,
      payment_date TEXT,
      FOREIGN KEY (rental_id) REFERENCES rentals(id)
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

  Future<void> printDatabaseDetails() async {
    final db = await database;

    print("📄 Database path: ${db.path}");

    int version = await db.getVersion();
    print("🔢 Database version: $version");

    // List all tables
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );

    print("\n📂 Tables in the database:");
    for (var table in tables) {
      String tableName = table['name'] as String;
      print("➡️ Table: $tableName");

      // Show table columns
      final columns = await db.rawQuery("PRAGMA table_info($tableName);");
      for (var column in columns) {
        print("   - ${column['name']} (${column['type']})");
      }
    }
  }

  Future<void> insertInitialUsers(Database db) async {
    await db.insert('users', {
      'username': 'admin',
      'hashed_password': hashPassword('1234'), // Example hash function
      'role': 'admin',
    });

    await db.insert('users', {
      'username': 'manager',
      'hashed_password': hashPassword('manager123'), // Example hash function
      'role': 'manager',
    });
  }

  // in DatabaseHelper

  Future<int> insertCar(Car car) async {
    final db = await database;
    print('Inserting car: ${car.toMap()}');
    return await db.insert(
      'cars',
      car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Car>> getAllCars() async {
    final db = await database;
    final result = await db.query('cars');
    return result.map((e) => Car.fromMap(e)).toList();
  }

  Future<Car?> getCarById(int id) async {
    final db = await database;
    final res = await db.query(
      'cars',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (res.isNotEmpty) {
      return Car.fromMap(res.first);
    }
    return null;
  }

  Future<int> updateCar(Car car) async {
    final db = await database;
    return await db.update(
      'cars',
      car.toMap(),
      where: 'id = ?',
      whereArgs: [car.id],
    );
  }

  Future<int> deleteCar(int id) async {
    final db = await database;
    return await db.delete('cars', where: 'id = ?', whereArgs: [id]);
  }

Future<int> insertRental(Rental rental) async {
  final db = await database;
  return await db.insert(
    'rentals',
    rental.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


}
