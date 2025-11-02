import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/helpers/app_colors.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

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
      body: Center(
        child: const Text("All Transaction Screen"),
      )
    );
  }
}
