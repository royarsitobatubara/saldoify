import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/helpers/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> initSplash() async {
    final isLogin = await UserPreferences.getDataBool('isLogin');
    await Future.delayed(Duration(seconds: 2));
    if(!mounted) return;
    context.go(isLogin==true?'/home':'/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: const Text("Logo"),
      ),
    );
  }
}
