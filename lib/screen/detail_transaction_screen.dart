import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/database/transaction_service.dart';
import 'package:saldoify/data/models/transaction_model.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/helpers/format_number.dart';
import 'package:saldoify/screen/layouts/screen_layout.dart';

class DetailTransactionScreen extends StatefulWidget {
  final int id;
  const DetailTransactionScreen({super.key, required this.id});

  @override
  State<DetailTransactionScreen> createState() => _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  
  late TransactionModel _data;
  
  Future<void> _getData() async {
    try{
      final data = await getTransactionById(widget.id);
      setState(() {
        _data = data!;
      });
    }catch(e){
      debugPrint('Terjadi kesalahan pada _getData: $e');
    }
  }

  Future<void> _deleteData() async {
    try{
      final data = await deleteTransactionById(widget.id);
      if(data > 0){
        if(!mounted) return;
        context.read<UserProvider>().loadTransactions();
        context.read<UserProvider>().loadAllTransactionData();
        context.pop();
        return;
      }
      debugPrint('Gagal menghapus transaksi');
    }catch(e){
      debugPrint('Terjadi kesalahan pada _deleteData: $e');
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  
  
  @override
  Widget build(BuildContext context) {

    return ScreenLayout(
      title: "Detail Transaction",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // ICON BESAR
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _data.type.toLowerCase() == "income"
                    ? Colors.green.withValues(alpha: .2)
                    : Colors.red.withValues(alpha: .2),
              ),
              child: Icon(
                _data.type == "income" ? Icons.arrow_downward : Icons.arrow_upward,
                size: 45,
                color: _data.type.toLowerCase() == "income" ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 15),

            // AMOUNT
            Text(
              "Rp ${formatRibuan(_data.nominal)}",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: _data.type == "income" ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 25),

            // KOTAK DETAIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    color: Colors.black.withValues(alpha: .15),
                  )
                ],
              ),
              child: Column(
                children: [
                  _detailItem("Title", _data.note),
                  _detailItem("Category", _data.category),
                  _detailItem("Date", _data.date),
                  _detailItem("Type", _data.type)
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ACTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: ()async=> await _deleteData(),
                    child: const Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
