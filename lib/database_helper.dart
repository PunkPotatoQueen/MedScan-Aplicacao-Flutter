import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//database
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'my_database.db');

    return openDatabase(databasePath, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE idoso (
        codigo INTEGER PRIMARY KEY
      )
    ''');

    await db.execute('''
      CREATE TABLE cuidador (
        codigo_idoso INTEGER REFERENCES idoso(codigo),
        email TEXT,
        nome TEXT,
        PRIMARY KEY (codigo_idoso, email)
      )
    ''');
  }
}
