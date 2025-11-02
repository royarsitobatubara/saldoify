import 'package:flutter/material.dart';
import 'package:saldoify/helpers/app_colors.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
              color: Colors.grey,
              offset: const Offset(0, 5),
              blurRadius: 10
          )]
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("Rp.0", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topRight: Radius.circular(20)
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Guest", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                  Text("12345678", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
