import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/helpers/format_number.dart';

class TransactionItem extends StatelessWidget {
  final String type;
  final String title;
  final String date;
  final String? category;
  final num nominal;
  final Color? color;
  final int? id;
  TransactionItem({
    super.key,
    this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.nominal,
    this.category,
    this.color
  });

  final Map<String, List<Map<String, IconData>>> _iconCategoryList = {
    'income': [
      {'Salary': Icons.work},
      {'Bonus': Icons.attach_money},
      {'Freelance': Icons.laptop_mac},
      {'Gift': Icons.card_giftcard},
      {'Investment': Icons.trending_up},
      {'Selling': Icons.shopping_bag},
      {'Cashback': Icons.wallet},
      {'Commission': Icons.payments},
      {'Business': Icons.store},
      {'Rental': Icons.home},
      {'Others': Icons.category},
    ],
    'outcome': [
      {'Food': Icons.fastfood},
      {'Transport': Icons.directions_car},
      {'Shopping': Icons.shopping_cart},
      {'Bills': Icons.receipt_long},
      {'Education': Icons.school},
      {'Health': Icons.local_hospital},
      {'Entertainment': Icons.movie},
      {'Hobby': Icons.palette},
      {'Groceries': Icons.local_grocery_store},
      {'Donation': Icons.volunteer_activism},
      {'Subscription': Icons.repeat},
      {'Tax': Icons.account_balance},
      {'Maintenance': Icons.build},
      {'Travel': Icons.flight},
      {'Others': Icons.category},
    ],
  };


  IconData getIcon() {
    final list = _iconCategoryList[type];
    if (list == null) return Icons.help_outline;
    for (final item in list) {
      if (item.keys.first.toLowerCase() == category) {
        return item.values.first;
      }
    }
    return Icons.help_outline;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>id != null?context.push('/detail-transaction', extra: id):null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if(color!=null)
                  Container(
                    width: 8,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color,
                    ),
                  ),
                const SizedBox(width: 5,),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: type=='income'?Colors.blueAccent:Colors.redAccent,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(
                    getIcon()
                  , color: Colors.white, size: 30,),
                ),
                const SizedBox(width: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    if (date.isNotEmpty)
                    Text(date.isEmpty ? '-' : date, style:const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 10),)
                  ],
                )
              ],
            ),
            Row(children: [
              Icon(Icons.arrow_forward_rounded, size: 12, color: type=='income'?Colors.blueAccent:Colors.redAccent,),
              const SizedBox(width: 5,),
              Text('${formatRibuan(nominal)},-', style:TextStyle(color: type=='income'?Colors.blueAccent:Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),),
            ],)
          ],),
      ),
    );
  }
}
