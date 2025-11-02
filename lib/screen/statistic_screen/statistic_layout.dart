import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String? selectedValue;

  late List<Map<String, dynamic>> _menu;

  final List<Color> colorList = [
    Color(0xFF6FDCCF),
    Color(0xFF9AD5E0),
    Color(0xFFF7A4A4),
    Color(0xFFFFE382),
    Color(0xFFC5C6FF),
    Color(0xFFB0EACD),
    Color(0xFFFFC6B9),
    Color(0xFFB5EAEA),
    Color(0xFFF6D186),
    Color(0xFFD7B4F3),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedValue = DateFormat("MMMM yyyy").format(now);

    _menu = [
      {'label': 'Income', 'screen': IncomeScreen(colors: colorList)},
      {'label': 'Outcome', 'screen': OutcomeScreen()},
    ];
  }

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  final List<String> months = DateFormat().dateSymbols.MONTHS
      .where((m) => m.isNotEmpty)
      .toList();

  final List<int> years = List.generate(30, (i) => 2000 + i);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              Row(
                children: [
                  // Dropdown bulan
                  DropdownButton<int>(
                    value: selectedMonth,
                    items: List.generate(12, (i) =>
                        DropdownMenuItem(
                          value: i + 1,
                          child: Text(months[i]),
                        ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value!;
                      });
                    },
                  ),

                  const SizedBox(width: 12),

                  // Dropdown tahun
                  DropdownButton<int>(
                    value: selectedYear,
                    items: years.map((y) => DropdownMenuItem(
                      value: y,
                      child: Text(y.toString()),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value!;
                      });
                    },
                  ),
                ],
              )

            ],
          ),
        ),
        const SizedBox(height: 10),
        buildButtonSwap(context),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: _menu[_currentIndex]['screen'],
          ),
        )
      ],
    );
  }

  Widget buildButtonSwap(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: _menu.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value['label'];

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _currentIndex == index ? AppColors.primary : Colors.transparent,
                      width: 3,
                    ),
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
