import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/helpers/app_image.dart';
import 'package:saldoify/widget/total_balances.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfile(context),
              const SizedBox(height: 10,),
              _buildSearchBar(context),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                const TotalBalances()
              ],
            ),
          ),
        )

      ],
    );
  }
  
  Widget _buildProfile(BuildContext context){
    final name = context.read<UserProvider>().name;
    return GestureDetector(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              AppImages.defaultProfile,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10,),
          const Text("Hello,", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),),
          Text(name, style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
        ],
      )
    );
  }

  Widget _buildSearchBar(BuildContext context){
    return Container(
      height: 45,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 22, color: Colors.black87),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _search,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
