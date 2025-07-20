import 'package:intl/intl.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/rental.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../controllers/my_scripts.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'users';

  Future<Database> get database async {
    if (_database != null) return _database!;
    databaseFactory = databaseFactoryFfi;
    _database = await openDatabase(
      await _getDatabasePath(),
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  Future<String> _getDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return join(dir.path, 'CRS_db.db');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        hashed_password TEXT,
        role TEXT DEFAULT 'user'
      )
    ''');
    await insertInitialUsers(db);

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
      )
    ''');

    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        phone TEXT,
        email TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE rentals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_name TEXT NOT NULL,
        car_id INTEGER NOT NULL,
        rent_date TEXT NOT NULL,
        return_date TEXT,
        total_price REAL,
        status TEXT DEFAULT 'active',
        FOREIGN KEY (car_id) REFERENCES cars(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rental_id INTEGER NOT NULL,
        amount_paid REAL,
        payment_date TEXT,
        FOREIGN KEY (rental_id) REFERENCES rentals(id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Migration logic can go here
  }

  // --- USERS ---
  Future<int> insertUser(String username, String hashedPassword) async {
    final db = await database;
    return await db.insert(tableName, {
      'username': username,
      'hashed_password': hashedPassword,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getAdmin() async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: 'role = ?',
      whereArgs: ['admin'],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> verifyPassword(String inputPassword) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['admin'],
      limit: 1,
    );

    if (result.isEmpty) return false;

    final stored = result.first['hashed_password'] as String;
    final hashed = hashPassword(inputPassword);
    return hashed == stored;
  }

  Future<void> insertInitialUsers(Database db) async {
    await db.insert('users', {
      'username': 'admin',
      'hashed_password': hashPassword('1234'),
      'role': 'admin',
    });
  }

  // --- CARS ---
  Future<int> insertCar(Car car) async {
    final db = await database;
    return await db.insert(
      'cars',
      car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> archiveCar(int id) async {
    final db = await database;
    await db.update(
      'cars',
      {'status': 'archived'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCar(int id) async {
    final db = await database;
    await db.delete('cars', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Car>> getAllCars() async {
    final db = await database;
    final result = await db.query('cars');
    return result.map((e) => Car.fromMap(e)).toList();
  }

  Future<Car?> getCarById(int id) async {
    final db = await database;
    final result = await db.query(
      'cars',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? Car.fromMap(result.first) : null;
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

  // --- RENTALS ---
  Future<int> insertRental(Rental rental) async {
    final db = await database;
    final car = await getCarById(rental.carId);
    if (car == null) throw Exception('Car not found.');
    return await db.insert(
      'rentals',
      rental.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getRentalsWithCarDetails() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        r.id, r.customer_name, r.car_id, r.rent_date, r.return_date, r.total_price,
        c.brand, c.model, c.plate_number
      FROM rentals r
      LEFT JOIN cars c ON r.car_id = c.id
      WHERE r.status != 'archived'
      ORDER BY r.id DESC
    ''');
  }

  Future<int> updateRental(Rental rental) async {
    final db = await database;
    return await db.update(
      'rentals',
      rental.toMap(),
      where: 'id = ?',
      whereArgs: [rental.id],
    );
  }

  Future<void> archiveRental(int id) async {
    final db = await database;
    await db.update(
      'rentals',
      {'status': 'archived'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- ARCHIVED DATA ---
  Future<List<Map<String, dynamic>>> getArchivedCars() async {
    final db = await database;
    return await db.query('cars', where: 'status = ?', whereArgs: ['archived']);
  }

  Future<List<Map<String, dynamic>>> getArchivedRentals() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        r.*, c.brand, c.model, c.plate_number
      FROM rentals r
      LEFT JOIN cars c ON r.car_id = c.id
      WHERE r.status = 'archived'
      ORDER BY r.rent_date DESC
    ''');
  }

  Future<void> restoreCar(int id) async {
    final db = await database;
    await db.update(
      'cars',
      {'status': 'available'}, // or 'active' if you're using that elsewhere
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> restoreRental(int id) async {
    final db = await database;
    await db.update(
      'rentals',
      {'status': 'active'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- REPORTS ---
  Future<double> getIncome({required bool isMonthly}) async {
    final db = await database;
    final now = DateTime.now();
    final format = isMonthly ? 'yyyy-MM' : 'yyyy-MM-dd';
    final clause = isMonthly
        ? 'strftime("%Y-%m", rent_date)'
        : 'date(rent_date)';
    final dateArg = DateFormat(format).format(now);

    final result = await db.rawQuery(
      '''
      SELECT SUM(total_price) as total FROM rentals WHERE $clause = ?
    ''',
      [dateArg],
    );

    return result.first['total'] != null
        ? (result.first['total'] as num).toDouble()
        : 0.0;
  }

  Future<int> getRentalCount({required bool isMonthly}) async {
    final db = await database;
    final now = DateTime.now();
    final format = isMonthly ? 'yyyy-MM' : 'yyyy-MM-dd';
    final clause = isMonthly
        ? 'strftime("%Y-%m", rent_date)'
        : 'date(rent_date)';
    final dateArg = DateFormat(format).format(now);

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as count FROM rentals WHERE $clause = ?
    ''',
      [dateArg],
    );

    return result.first['count'] as int;
  }

  Future<List<Map<String, dynamic>>> getTopRentedCars({int limit = 5}) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        c.id,
        c.brand || ' ' || c.model AS fullName,
        COUNT(r.id) AS rentalCount
      FROM rentals r
      JOIN cars c ON c.id = r.car_id
      GROUP BY c.id
      ORDER BY rentalCount DESC
      LIMIT $limit
    ''');
  }

  Future<List<Map<String, dynamic>>> getRentalsInDateRange(
    DateTime from,
    DateTime to,
  ) async {
    final db = await database;
    final fromStr = from.toIso8601String().substring(0, 10); // 'YYYY-MM-DD'
    final toStr = to.toIso8601String().substring(0, 10);
    return await db.rawQuery(
      '''
    SELECT rentals.*, cars.brand, cars.model, cars.plate_number
    FROM rentals
    INNER JOIN cars ON rentals.car_id = cars.id
    WHERE rentals.rent_date BETWEEN ? AND ?
    AND rentals.is_archived = 0
    ORDER BY rentals.rent_date DESC
  ''',
      [fromStr, toStr],
    );
  }

  // --- DEBUG ---
  Future<void> printDatabaseDetails() async {
    final db = await database;
    print("📄 DB Path: ${db.path}");
    print("🔢 Version: ${await db.getVersion()}");

    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );

    for (var t in tables) {
      final name = t['name'];
      final columns = await db.rawQuery("PRAGMA table_info($name);");
      print("📂 $name");
      for (var c in columns) {
        print("   - ${c['name']} (${c['type']})");
      }
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
