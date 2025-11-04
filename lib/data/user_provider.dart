import 'package:flutter/material.dart';
import 'package:saldoify/data/database/transaction_service.dart';
import 'package:saldoify/data/database/user_service.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/models/user_model.dart';
import 'package:saldoify/data/user_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  int _totalBalance = 0;
  int _income = 0;
  int _outcome =0;
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;
  String _transactionType = 'Income';
  List<TransactionModel> _transactionList = [];
  List<TransactionModel> _allTransactionList = [];
  List<UserModel> _userList = [];

  String get name => _name;
  int get totalBalance => _totalBalance;
  int get month => _month;
  int get income => _income;
  int get outcome => _outcome;
  int get year => _year;
  String get transactionType => _transactionType;
  List<TransactionModel> get transactionList => _transactionList;
  List<TransactionModel> get allTransactionList => _allTransactionList;
  List<UserModel> get userList => _userList;

  UserProvider() {
    loadName();
    loadTotalBalance();
    loadTransactions();
    loadAllTransactions();
    getAllUser();
    loadIncomeOutcome();
    loadAllTransactionData();
  }

  Future<void> loadAll() async {
    try {
      loadName();
      loadTotalBalance();
      loadTransactions();
      loadAllTransactions();
      getAllUser();
      loadIncomeOutcome();
    } catch (e) {
      debugPrint('Failed to load: $e');
    }
  }
  Future<void> loadAllTransactionData() async {
    try {
      loadTotalBalance();
      loadTransactions();
      loadAllTransactions();
      loadIncomeOutcome();
    } catch (e) {
      debugPrint('Failed to loadAllTransaction: $e');
    }
  }

  Future<void> loadName() async {
    try {
      final id = await UserPreferences.getDataInt('userId');
      if (id == null) return;
      final data = await getUserById(id: id);
      if (data != null) {
        _name = data.name;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to load name: $e');
    }
  }

  Future<void> loadTransactions() async {
    try {
      final userId = await UserPreferences.getDataInt('userId');
      if (userId == null) return;

      final data = await getTransactionByIdDateCategory(
        type: _transactionType,
        month: _month,
        year: _year,
        userId: userId,
      );

      _transactionList = data;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loadTransactions: $e');
      _transactionList = [];
      notifyListeners();
    }
  }

  Future<void> loadTotalBalance() async {
    try {
      final id = await UserPreferences.getDataInt('userId');
      if (id == null) return;
      final data = await getBalance(id: id);
      if (data != null) {
        _totalBalance = data;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loadTotalBalance: $e');
    }
  }

  /// Set month & year lalu reload transaksi
  Future<void> setMonthYear({required int month, required int year}) async {
    _month = month;
    _year = year;
    await loadTransactions();
  }

  /// Set tipe transaksi (Income/Outcome) dan reload
  Future<void> setTransactionType(String type) async {
    _transactionType = type;
    await loadTransactions();
  }

  Future<void> loadAllTransactions() async {
    try {
      final data = await getTransaction();
      _allTransactionList = data;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loadAllTransactions: $e');
      _transactionList = [];
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    try {
      final data = await getAllUser();
      _userList = data;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loadUser: $e');
      _userList = [];
      notifyListeners();
    }
  }

  Future<void> loadIncomeOutcome() async {
    try {
      _income = await getTypeBalance('income');
      _outcome = await getTypeBalance('outcome');
    } catch (e) {
      debugPrint('Error loadIncomeOutcome: $e');
      _income = 0;
      _outcome = 0;
    }
    notifyListeners();
  }

}
