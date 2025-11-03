import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/widget/graph.dart';
import 'package:saldoify/widget/transaction_item.dart';

class OutcomeScreen extends StatelessWidget {
  final List<Color> colors;
  const OutcomeScreen({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        final dataList = provider.transactionList.where((e) => e.type.toLowerCase() == 'outcome').toList();
        if (dataList.isEmpty) return const Center(child: Text('No Outcome Data'));

        Map<String, double> dataMap = {};
        double total = 0;
        for (var trx in dataList) {
          dataMap[trx.category] = (dataMap[trx.category] ?? 0) + trx.nominal.toDouble();
          total += trx.nominal.toDouble();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Graph(title: 'Total\n\$${total.toStringAsFixed(0)}', listColor: colors, dataMap: dataMap),
            const SizedBox(height: 20),
            const Text('Outcome Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: dataMap.length,
                itemBuilder: (context, index) {
                  final key = dataMap.keys.toList()[index];
                  final value = dataMap[key]!;
                  return TransactionItem(type: 'outcome', title: key, date: '', nominal: value, category: key.toLowerCase(), color: index < colors.length ? colors[index] : Colors.grey,);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}