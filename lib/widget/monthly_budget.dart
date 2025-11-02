import 'package:flutter/material.dart';

class MonthlyBudget extends StatelessWidget {
  const MonthlyBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 10)]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.motion_photos_on_rounded, size: 40, color: Colors.orange,),
              const SizedBox(width: 10,),
              const Text("Monthly Budget", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),)
            ],
          ),
          const Text("Rp.0", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),)
        ],
      ),
    );
  }
}
