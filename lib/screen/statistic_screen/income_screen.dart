import 'package:flutter/material.dart';
import 'package:saldoify/widget/chart_transaction_item.dart';
import 'package:saldoify/widget/graph.dart';

class IncomeScreen extends StatelessWidget {
  final List<Color> colors;
  IncomeScreen({super.key, required this.colors});

  final Map<String, double> dataMap = {
    'oi': 10,
    'cihuy':60,
    'ihuy':60,
    'cihsuy':60,
    'ihusy':60,
    'as':90
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Graph(
          title: 'total\n20000',
          listColor: colors,
          dataMap: dataMap,
        ),
        const SizedBox(height: 20,),
        const Text('Income Breakdown', textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        const SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemCount: dataMap.length,
            itemBuilder: (context, index) {
              final key = dataMap.keys.toList()[index];
              final value = dataMap[key] ?? 0;

              return ChartTransactionItem(
                category: key,
                precent: value.toInt(),
                color: index < colors.length ? colors[index] : Colors.grey,
                amount: value,
              );
            },
          ),
        ),

      ],
    );
  }
}
