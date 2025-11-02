import 'package:flutter/material.dart';

class ChartTransactionItem extends StatelessWidget {
  final String category;
  final double amount;
  final Color color;
  final int precent;
  final bool? isIncome;
  const ChartTransactionItem({
    super.key,
    required this.category,
    required this.precent,
    required this.color,
    required this.amount,
    this.isIncome = true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(isIncome == true ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: isIncome == true? Colors.greenAccent : Colors.redAccent, size: 30,),
              Text(category, style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15
              )),
            ],
          ),
          Text('Rp.$amount', style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13
          ),),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3)
            ),
            child: Text('$precent%', style: const TextStyle(
              fontSize: 8,
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),),
          )
        ],
      ),
    );
  }
}
