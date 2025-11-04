import 'package:flutter/cupertino.dart';
import 'package:saldoify/data/database/db_helper.dart';
import 'package:saldoify/data/models/user_model.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:sqflite/sqflite.dart';

const String _table = 'users';

Future<int> register({required String name, required String password}) async {
  try{
    final db = await DBHelper().database;
    int id = await db.insert(_table, conflictAlgorithm: ConflictAlgorithm.replace,UserModel(
      name: name,
      password: password,
      balance: 0,
      profile: '',
    ).toJson());
    return id;
  }catch(e){
    debugPrint('Terjadi kesalahan pada register: $e');
    return -1;
  }
}

Future<int> login({required String name, required String password}) async {
  try {
    final db = await DBHelper().database;
    final data = await db.query(
      _table,
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
      limit: 1,
    );
    if (data.isNotEmpty) {
      return data[0]['id'] as int;
    } else {
      return -1;
    }
  } catch (e) {
    debugPrint('Terjadi kesalahan pada login: $e');
    return -1;
  }
}

Future<UserModel?> getUserById({required int id}) async {
  try {
    final db = await DBHelper().database;
    final data = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      return UserModel.fromJson(data[0]);
    } else {
      return null;
    }
  } catch (e) {
    debugPrint('Terjadi kesalahan pada getUserById: $e');
    return null;
  }
}

Future<int> addBalance({required int id, required int nominal}) async {
  try {
    final db = await DBHelper().database;
    final data = await db.query(
      _table,
      columns: ['balance'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isEmpty) return 0;
    int currentBalance = data[0]['balance'] as int;
    int newBalance = currentBalance + nominal;

    // Update ke database
    int count = await db.update(
      _table,
      {'balance': newBalance},
      where: 'id = ?',
      whereArgs: [id],
    );
    return count;
  } catch (e) {
    debugPrint('Terjadi kesalahan pada addBalance: $e');
    return 0;
  }
}

Future<int?> getBalance({required int id}) async {
  try {
    final db = await DBHelper().database;
    final data = await db.query(
      'users',
      columns: ['balance'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (data.isNotEmpty) {
      return data[0]['balance'] as int;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint('Terjadi kesalahan pada getBalance: $e');
    return null;
  }
}

Future<void> deleteUser() async {
  try{
    final id = await UserPreferences.getDataInt('userId');
    final db = await DBHelper().database;
    await db.delete(_table, where: 'id=?', whereArgs: [id]);
  }catch(e){
    debugPrint('Terjadi kesalahan pada deleteUser: $e');
  }
}

Future<List<UserModel>> getAllUser() async {
  try{
    final db = await DBHelper().database;
    final data = await db.query(_table);
    return data.map((e)=>UserModel.fromJson(e)).toList();
  }catch(e){
    debugPrint('Terjadi kesalahan pada getAllUser: $e');
    return [];
  }
}

Future<void> editPassword({required id, required newPassword}) async {
  try{
    final db = await DBHelper().database;
    await db.update(_table, {'password': newPassword}, where: 'id=?', whereArgs: [id]);
  }catch(e){
    debugPrint('Terjadi kesalahan pada editPassword: $e');
  }
}




