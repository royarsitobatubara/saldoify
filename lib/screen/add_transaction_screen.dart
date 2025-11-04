import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/database/transaction_service.dart';
import 'package:saldoify/data/database/user_service.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/screen/layouts/screen_layout.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nominalController = TextEditingController();
  final _noteController = TextEditingController();
  String _type = 'Income';
  String? _selectedCategory;

  final List<String> incomeCategories = [
    'Salary','Bonus','Freelance','Gift','Investment','Selling',
    'Cashback','Commission','Business','Rental','Others',
  ];

  final List<String> outcomeCategories = [
    'Food','Transport','Shopping','Bills','Education','Health','Entertainment',
    'Hobby','Groceries','Donation','Subscription','Tax','Maintenance','Travel','Others',
  ];

  DateTime now = DateTime.now();
  late String date = DateFormat('dd-MM-yyyy').format(now);

  List<String> get currentCategories => _type == 'Income'
      ? incomeCategories
      : outcomeCategories;

  @override
  void dispose() {
    _nominalController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveTransaction() async {
    try {
      final userId = await UserPreferences.getDataInt('userId');
      if (userId == null || _selectedCategory == null || _nominalController.text.isEmpty) return;

      final nominal = int.parse(_nominalController.text);

      final result = await addTransaction(TransactionModel(
        userId: userId,
        category: _selectedCategory!,
        nominal: nominal,
        note: _noteController.text,
        type: _type,
        date: date,
      ));

      if (result >= 1) {
        if (_type == 'Income') {
          await addBalance(id: userId, nominal: nominal);
        } else {
          await addBalance(id: userId, nominal: -nominal);
        }

        if (!mounted) return;
        context.read<UserProvider>().loadTransactions();
        context.read<UserProvider>().loadTotalBalance();
        context.read<UserProvider>().loadAllTransactions();

        context.go('/feedback', extra: 'Transaction added successfully');
      }
    } catch (e) {
      debugPrint('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: 'Add Transaction',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Header icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: _type == 'Income' ? Colors.green.shade100 : Colors.red.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _type == 'Income'
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: _type == 'Income' ? Colors.green : Colors.red,
                      size: 35,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Type
                const Text('Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ChoiceChip(
                      label: const Text('Income'),
                      selected: _type == 'Income',
                      selectedColor: Colors.green.shade300,
                      onSelected: (b) {
                        setState(() {
                          _type = 'Income';
                          _selectedCategory = null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Outcome'),
                      selected: _type == 'Outcome',
                      selectedColor: Colors.red.shade300,
                      onSelected: (b) {
                        setState(() {
                          _type = 'Outcome';
                          _selectedCategory = null;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // Category
                const Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),

                DropdownButtonFormField(
                  initialValue: _selectedCategory,
                  items: currentCategories.map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  )).toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  decoration: _decor(),
                  validator: (val) => val == null ? 'Please select category' : null,
                ),

                const SizedBox(height: 25),

                // Nominal
                const Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),

                TextFormField(
                  controller: _nominalController,
                  keyboardType: TextInputType.number,
                  decoration: _decor(hint: 'Enter amount'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),

                const SizedBox(height: 25),

                // Note
                const Text('Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),

                TextFormField(
                  controller: _noteController,
                  decoration: _decor(hint: 'Optional'),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveTransaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _type == 'Income' ? Colors.green : Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 3,
                    ),
                    child: const Text('Save', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decor({String? hint}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }
}
