import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/screen/home_screen.dart';
import 'package:saldoify/screen/statistic_screen/statistic_layout.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _screen = [
    {'screen': HomeScreen(), 'icon': Icons.home_filled},
    {'screen': const StatisticLayout(), 'icon': Icons.candlestick_chart_sharp},
    {'screen': const Center(child: Text("development")), 'icon': Icons.device_unknown},
    {'screen': const Center(child: Text("development")), 'icon': Icons.wallet}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreign,
      appBar: AppBar(backgroundColor: AppColors.primary, elevation: 0, toolbarHeight: 0,),
      body: SafeArea(
        child: _screen[_currentIndex]['screen'],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>context.push('/add-transaction'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_sharp, size: 26, color: Colors.white,),
      ),
    );
  }
  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.primary,
      child: SizedBox(
        height: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_screen.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    _screen[index]['icon'],
                    color: _currentIndex == index ? AppColors.primary : Colors.white,
                    size: 25,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
