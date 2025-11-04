import 'package:flutter/material.dart';
import 'package:saldoify/helpers/app_colors.dart';

class ScreenLayout extends StatelessWidget {
  final String title;
  final Widget child;
  const ScreenLayout({super.key, required this.title,required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreign,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.foreign,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(20))
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}
