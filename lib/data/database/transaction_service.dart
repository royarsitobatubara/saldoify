import 'package:flutter/cupertino.dart';
import 'package:saldoify/data/database/db_helper.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/user_preferences.dart';

const String _table = 'transactions';

Future<int> addTransaction(TransactionModel item) async {
  try{
    final data = await DBHelper().database;
    return await data.insert(
      _table,
      TransactionModel(
        userId: item.userId,
        category: item.category,
        nominal: item.nominal,
        note: item.note,
        type: item.type,
        date: item.date
      ).toJson()
    );
  }catch(e){
    debugPrint('Terjadi kesalahan pada addTransaction: $e');
    return -1;
  }
}

Future<List<TransactionModel>> getTransaction() async{
  try{
    final userId = await UserPreferences.getDataInt('userId');
    if(userId == null){
      debugPrint('User id tidak ditemukan');
      return [];
    }
    final data = await DBHelper().database;
    final result = await data.query(_table, where: 'userId = ?', whereArgs: [userId]);
    return result.map((e) => TransactionModel.fromJson(e)).toList();
  }catch(e){
    debugPrint('Terjadi kesalahan getTransaction: $e');
    return [];
  }
}

Future<List<TransactionModel>> getTransactionByIdDateCategory({
  required String type,
  required int month,
  required int year,
  required int userId,
}) async {
  try {
    final db = await DBHelper().database;

    // Ambil semua transaksi user
    final result = await db.query(
      _table,
      where: 'userId = ? AND type = ?',
      whereArgs: [userId, type],
    );

    // Parse tanggal dan filter bulan & tahun
    final filtered = result.map((e) {
      final trx = TransactionModel.fromJson(e);
      final parts = trx.date.split('-'); // dd-MM-yyyy
      if (parts.length != 3) return null;
      final trxDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
      return {
        'trx': trx,
        'date': trxDate,
      };
    }).where((e) => e != null).toList();

    final finalList = filtered
        .where((e) =>
    (e!['date'] as DateTime).month == month &&
        (e['date'] as DateTime).year == year)
        .map((e) => e!['trx'] as TransactionModel)
        .toList();

    return finalList;
  } catch (e) {
    debugPrint('Error getTransactionByIdDateCategory: $e');
    return [];
  }
}

Future<void> deleteTransaction() async {
  try{
    final userId = await UserPreferences.getDataInt('userId');
    final db = await DBHelper().database;
    await db.delete(_table, where: 'userId = ?', whereArgs: [userId]);
  }catch(e){
    debugPrint('Terjadi kesalahan pada deleteTransaction:  $e');
  }
}

Future<TransactionModel?> getTransactionById(int id) async {
  try {
    final db = await DBHelper().database;

    final result = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id] ,
      limit: 1
    );

    if (result.isNotEmpty) {
      return TransactionModel.fromJson(result.first);
    }
    return null;
  } catch (e) {
    debugPrint('Terjadi kesalahan getTransactionById: $e');
    return null;
  }
}
