import 'package:flutter/material.dart';

class InfoIncomeOutcome extends StatelessWidget {
  const InfoIncomeOutcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey, offset: const Offset(0, 5), blurRadius: 8)]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Income', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 5,),
                    const Icon(Icons.trending_up, color: Colors.white, size: 25,),
                  ],
                ),
                Text('Rp. 100.000', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey, offset: const Offset(0, 5), blurRadius: 8)]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Income', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 5,),
                    const Icon(Icons.trending_down, color: Colors.white, size: 25,),
                  ],
                ),
                Text('Rp. 100.000', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
          ),
        )
      ],
    );
  }
}
