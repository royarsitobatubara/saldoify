import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/helpers/app_image.dart';
import 'package:saldoify/widget/info_income_outcome.dart';
import 'package:saldoify/widget/total_balances.dart';
import 'package:saldoify/widget/transaction_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadTotalBalance();
      context.read<UserProvider>().loadAllTransactions();
    });

    _search.addListener(() {
      setState(() {}); // rebuild saat teks berubah
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }



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
                const TotalBalances(),
                const SizedBox(height: 20,),
                const InfoIncomeOutcome(),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Last Transaction', style: TextStyle(fontWeight: FontWeight.w600),),
                    GestureDetector(
                      onTap: ()=>context.push('/transaction'),
                      child: Row(children: [
                        const Icon(Icons.keyboard_arrow_down),
                        const Text('All', style: TextStyle(fontWeight: FontWeight.w500),),
                      ],),
                    )
                  ],
                ),
                Expanded(
                  child: Selector<UserProvider, List<TransactionModel>>(
                    selector: (_, prov) => prov.allTransactionList,
                    builder: (_, transaction, __) {
                      if (transaction.isEmpty) {
                        return const Center(child: Text('No transaction yet'));
                      }

                      // Ambil teks pencarian
                      final searchText = _search.text.toLowerCase();

                      // Filter berdasarkan note atau category
                      final filteredTransaction = transaction.where((trx) {
                        final note = trx.note.toLowerCase();
                        final category = trx.category.toLowerCase();
                        return note.contains(searchText) || category.contains(searchText);
                      }).toList();

                      final reversedTransaction = filteredTransaction.reversed.toList();

                      if (reversedTransaction.isEmpty) {
                        return const Center(child: Text('No transaction found'));
                      }

                      return ListView.builder(
                        itemCount: reversedTransaction.length > 8 ? 8 : reversedTransaction.length,
                        itemBuilder: (context, index) {
                          final trx = reversedTransaction[index];
                          return TransactionItem(
                            type: trx.type.toLowerCase(),
                            title: trx.note,
                            date: trx.date,
                            nominal: trx.nominal,
                            category: trx.category.toLowerCase(),
                            id: trx.id!,
                          );
                        },
                      );
                    },
                  ),
                )

              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfile(BuildContext context){
    return GestureDetector(
      onTap: ()=>context.push('/settings'),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppImages.defaultProfile,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hello,", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              Selector<UserProvider, String>(
                selector: (_, prov) => prov.name,
                builder: (_, name, __) {
                  return Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
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
