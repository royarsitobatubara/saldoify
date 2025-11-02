import 'package:flutter/foundation.dart';
import 'package:saldoify/data/database/db_service.dart';
import 'package:saldoify/data/models/category_model.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/user_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = "Guest";
  List<TransactionModel> _transactionList = [];
  List<CategoryModel> _categoryList = [];

  String get name => _name;
  List<TransactionModel> get transactionModel => _transactionList;
  List<CategoryModel> get categoryModel => _categoryList;

  UserProvider() {
    loadName();
    loadTransactions();
    loadCategory();
  }

  // <================================ NAME ===================================>
  Future<void> loadName() async {
    try{
      final name = await UserPreferences.getDataString('name');
      _name = name.trim().isEmpty ? 'Guest' : name;
      notifyListeners();
    }catch(e){
      debugPrint('Failed to get name: $e');
    }
  }

  Future<void> setName(String newName) async {
    try{
      _name = newName;
      await UserPreferences.setDataString('name', newName);
      notifyListeners();
    }catch(e){
      debugPrint('Failed to set name: $e');
    }
  }

  // <============================== TRANSACTION ==============================>
  Future<void> loadTransactions() async {
    try{
      final transaction = await DBService.getTransaction;
      _transactionList = transaction;
      notifyListeners();
    }catch(e){
      debugPrint('Failed to get transaction: $e');
    }
  }

  Future<void> setTransactions(TransactionModel item) async {
    try {
      await DBService.setTransaction(item);
      _transactionList.add(item);
      notifyListeners();
    } catch (e) {
      debugPrint("Failed to set transaction: $e");
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await DBService.deleteTransaction(id);
      _transactionList.removeWhere((tx) => tx.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Failed to delete transaction: $e");
    }
  }

  // <=============================== CATEGORY ================================>
  Future<void> loadCategory() async {
    try {
      final category = await DBService.getCategory;
      _categoryList = category;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to get category: $e');
    }
  }

  Future<void> setCategory(CategoryModel item) async {
    try {
      await DBService.setCategory(item);
      _categoryList.add(item);
      notifyListeners();
    } catch (e) {
      debugPrint("Failed to set category: $e");
    }
  }

  Future<void> updateCategory(CategoryModel item) async {
    try {
      await DBService.updateCategory(item);
      final index = _categoryList.indexWhere((cat) => cat.id == item.id);
      if (index != -1) {
        _categoryList[index] = item;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Failed to update category: $e");
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await DBService.deleteCategory(id);
      _categoryList.removeWhere((cat) => cat.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Failed to delete category: $e");
    }
  }

}

