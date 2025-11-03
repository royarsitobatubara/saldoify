import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper()=> _instance;

  final String _dbName = "saldoify.db";

  // <============================ AMBIL DATABASE =============================>
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // <========================= INISIALISASI DATABASE =========================>
  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // <============================= HAPUS DATABASE ===========================>
  Future<void> deleteDatabaseFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);

    if(_database != null) {
      await _database!.close();
      _database = null;
    }

    if (await File(path).exists()) {
      await File(path).delete();
    }
  }

  // <============================= TABLE DATABASE ============================>
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER,
      category TEXT,
      nominal INT,
      note TEXT,
      type TEXT,
      date TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      profile TEXT,
      balance INT,
      password TEXT
    )
  ''');
  }
}
