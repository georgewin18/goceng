import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:goceng/models/order.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'order.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            destination TEXT,
            dateTime TEXT,
            price INTEGER,
            rating REAL,
            serviceType TEXT
          )
        ''');
      },
    );
  }

  static Future<void> createOrder(Order order) async {
    final db = await database;
    await db.insert('orders', order.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Order>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders');
    return List.generate(maps.length, (i) => Order.fromMap(maps[i]));
  }
}