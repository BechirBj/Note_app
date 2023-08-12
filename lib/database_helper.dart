// database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database does not exist yet, create it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'login.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE login_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertLoginData(String username, String password) async {
    final db = await database;
    await db.insert(
      'login_data',
      {
        'username': username,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getLoginData() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('login_data');
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
