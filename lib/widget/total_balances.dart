import 'package:flutter/material.dart';
import 'package:saldoify/helpers/app_colors.dart';

class TotalBalances extends StatelessWidget {
  const TotalBalances({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, offset: const Offset(0, 5), blurRadius: 8)]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Balance', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
              const Text('Rp. 100.000', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(Icons.arrow_drop_up, color: AppColors.primary, size: 20,),
                Text('7%', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
