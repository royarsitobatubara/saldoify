import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/screen/statistic_screen/income_screen.dart';
import 'package:saldoify/screen/statistic_screen/outcome_screen.dart';

class StatisticLayout extends StatefulWidget {
  const StatisticLayout({super.key});

  @override
  State<StatisticLayout> createState() => _StatisticLayoutState();
}

class _StatisticLayoutState extends State<StatisticLayout> {
  int _currentIndex = 0;
  late List<String> months;
  late List<int> years;

  final List<Color> colorList = [
    const Color(0xFF6FDCCF),
    const Color(0xFF9AD5E0),
    const Color(0xFFF7A4A4),
    const Color(0xFFFFE382),
    const Color(0xFFC5C6FF),
    const Color(0xFFB0EACD),
    const Color(0xFFFFC6B9),
    const Color(0xFFB5EAEA),
    const Color(0xFFF6D186),
    const Color(0xFFD7B4F3),
  ];

  @override
  void initState() {
    super.initState();
    months = DateFormat().dateSymbols.MONTHS.where((m) => m.isNotEmpty).toList();
    years = List.generate(30, (i) => 2000 + i);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header + Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Statistics',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.foreign),
              ),
              Row(
                children: [
                  DropdownButton<int>(
                    value: userProvider.month,
                    items: List.generate(
                        12,
                            (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text(months[i]),
                        )),
                    onChanged: (val) {
                      if (val != null) {
                        userProvider.setMonthYear(month: val, year: userProvider.year);
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<int>(
                    value: userProvider.year,
                    items: years
                        .map((y) => DropdownMenuItem(
                      value: y,
                      child: Text(y.toString()),
                    ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        userProvider.setMonthYear(month: userProvider.month, year: val);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        buildButtonSwap(userProvider),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: userProvider.transactionType == 'Income'
                ? IncomeScreen(colors: colorList)
                : OutcomeScreen(colors: colorList),
          ),
        ),
      ],
    );
  }

  Widget buildButtonSwap(UserProvider provider) {
    final menu = ['Income', 'Outcome'];
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: menu.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _currentIndex = index);
                provider.setTransactionType(label);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: _currentIndex == index ? AppColors.primary : Colors.transparent,
                        width: 3),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
