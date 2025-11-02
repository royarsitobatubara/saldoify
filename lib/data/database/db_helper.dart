import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper()=> _instance;

  // <============================ AMBIL DATABASE =============================>
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // <========================= INISIALISASI DATABASE =========================>
  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'saldoify.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }

  // <============================= TABLE DATABASE ============================>
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INT PRIMARY KEY AUTOINCREMENT
        category TEXT
        nominal REAL
        note TEXT
        type TEXT
        date TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE categories (
        id INT PRIMARY KEY AUTOINCREMENT
        category TEXT
        type TEXT
      )
    ''');
  }
}