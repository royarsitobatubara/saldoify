import 'package:flutter/cupertino.dart';
import 'package:saldoify/data/database/db_helper.dart';
import 'package:saldoify/data/models/category_model.dart';
import 'package:saldoify/data/models/transaction_model.dart';

class DBService {

  static const _tableTransactions = 'transactions';
  static const _tableCategories = 'categories';

  // <========================= SERVICE TRANSACTIONS ==========================>
  // [GET]
  static Future<List<TransactionModel>> get getTransaction async {
    try{
      final db = await DBHelper().database;
      final data = await db.query(_tableTransactions);
      return data.map((itm) => TransactionModel.fromJson(itm)).toList();
    }catch(e){
      debugPrint('Failed get transaction: $e');
      return [];
    }
  }

  // [SET]
  static Future<void> setTransaction(TransactionModel item) async {
    try{
      final db = await DBHelper().database;
      await db.insert(_tableTransactions, item.toJson());
    }catch(e){
      debugPrint('Failed set transaction: $e');
    }
  }

  // [DELETE]
  static Future<int> deleteTransaction(int id) async {
    try {
      final db = await DBHelper().database;
      return await db.delete(
        _tableTransactions,
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('Failed delete transaction: $e');
      return 0;
    }
  }

  // <========================== SERVICE CATEGORIES ===========================>
  // [GET]
  static Future<List<CategoryModel>> get getCategory async {
    try{
      final db = await DBHelper().database;
      final data = await db.query(_tableCategories);
      return data.map((itm) => CategoryModel.fromJson(itm)).toList();
    }catch(e){
      debugPrint('Failed get category: $e');
      return [];
    }
  }

  // [SET]
   static Future<void> setCategory(CategoryModel item) async {
      try{
        final db = await DBHelper().database;
        await db.insert(_tableCategories, item.toJson());
      }catch(e){
        debugPrint('Failed set category: $e');
      }
   }

   // [UPDATE]
  static Future<int> updateCategory(CategoryModel item) async {
    try {
      final db = await DBHelper().database;
      return await db.update(
        _tableCategories,
        item.toJson(),
        where: 'id=?',
        whereArgs: [item.id],
      );
    } catch (e) {
      debugPrint('Failed update category: $e');
      return 0;
    }
  }

  // [DELETE]
  static Future<int> deleteCategory(int id) async {
    try {
      final db = await DBHelper().database;
      return await db.delete(
        _tableCategories,
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('Failed delete category: $e');
      return 0;
    }
  }


}