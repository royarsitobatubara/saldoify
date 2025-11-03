import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/widget/transaction_item.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadAllTransactions();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()=>context.pop(),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary
            ),
            icon: Icon(Icons.arrow_back_ios_new_outlined, size: 25, color: Colors.white,)
        ),
        title: Text('All Transaction', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Selector<UserProvider, List<TransactionModel>>(
            selector: (_, prov) => prov.allTransactionList,
            builder: (_, transaction, __) {
              if (transaction.isEmpty) {
                return const Center(child: Text('No transaction yet'));
              }
              final reversedTransaction = transaction.reversed.toList();
              return ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (context, index) {
                  final trx = reversedTransaction[index];
                  return TransactionItem(
                    type: trx.type.toLowerCase(),
                    title: trx.note,
                    date: trx.date,
                    nominal: trx.nominal,
                    category: trx.category.toLowerCase(),
                  );
                },
              );
            },
          ),
        ),
      )
    );
  }
}
