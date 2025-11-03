import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/helpers/app_colors.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 80,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Berhasil ditambahkan!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Data kamu sudah tersimpan dengan aman.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: .8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                  onPressed: ()=>context.go('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.foreign,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                  child: const Text('Submit', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
