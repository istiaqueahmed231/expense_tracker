import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class LocalDbService extends GetxService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // 1. Categories Table (Auto-increment ID)
      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          type TEXT NOT NULL,
          is_predefined INTEGER DEFAULT 0
        )
      ''');

      // 2. Transactions Table (Timestamp and Description included)
      await db.execute('''
        CREATE TABLE transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_id INTEGER,
          amount REAL NOT NULL,
          description TEXT,
          type TEXT NOT NULL,
          timestamp TEXT NOT NULL,
          FOREIGN KEY (category_id) REFERENCES categories (id)
        )
      ''');

      // 3. Insert Predefined Categories
      await db.rawInsert('INSERT INTO categories (name, type, is_predefined) VALUES ("Salary", "income", 1)');
      await db.rawInsert('INSERT INTO categories (name, type, is_predefined) VALUES ("Food", "expense", 1)');
      await db.rawInsert('INSERT INTO categories (name, type, is_predefined) VALUES ("Rent", "expense", 1)');
    });
  }

  // --- FEATURES ---

  // Add a new custom category
  Future<int> addCategory(String name, String type) async {
    var dbClient = await db;
    return await dbClient.insert('categories', {'name': name, 'type': type, 'is_predefined': 0});
  }

  // Fetch transactions of a certain category
  Future<List<Map<String, dynamic>>> getExpensesByCategory(int categoryId) async {
    var dbClient = await db;
    return await dbClient.query('transactions', where: 'category_id = ?', whereArgs: [categoryId]);
  }

  // Get remaining balance and total expense for a specific month
  Future<Map<String, double>> getMonthlyStats(String yearMonth) async {
    var dbClient = await db;
    // Query filter uses the timestamp string (e.g., '2026-03%')
    var result = await dbClient.rawQuery('''
      SELECT 
        SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as total_income,
        SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as total_expense
      FROM transactions 
      WHERE timestamp LIKE "$yearMonth%"
    ''');

    double income = double.tryParse(result[0]['total_income'].toString()) ?? 0.0;
    double expense = double.tryParse(result[0]['total_expense'].toString()) ?? 0.0;

    return {
      'total_expense': expense,
      'remaining_balance': income - expense,
    };
  }
}