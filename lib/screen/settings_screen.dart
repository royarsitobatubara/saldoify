import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/database/db_helper.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/helpers/app_image.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> showConfirmDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onSubmit,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Icon(
            Icons.help_outline,
            size: 120,
            color: Colors.amber,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onSubmit();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreign,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.foreign,
        title:const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              _builCard(context: context,label: 'Account', icon: Icons.person, children: [
                GestureDetector(
                  onTap: ()=>context.push('/profile'),
                  child: Row(
                    children: [
                      ClipOval(child: Image.asset(AppImages.defaultProfile, width: 80, height: 80,),),
                      const SizedBox(width: 10,),
                      Selector<UserProvider, String>(
                        selector: (_, prov)=>prov.name,
                        builder: (_, value, _){
                          return Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, ),);
                        },
                      )
                    ],
                  ),
                )
              ]),

              _builCard(context: context,label: 'Storage', icon: Icons.storage, children: [_buildMenuItem(context: context, icon: Icons.delete, label: 'Delete storage', onClick: ()=>  showConfirmDialog(context: context, title: 'Are you sure to delete data?', onSubmit: () async{
                await DBHelper().deleteDatabaseFile();
                await UserPreferences.deleteData();
                if(!context.mounted) return;
                context.go('/splash');
              }))])
            ],
          ),
        ),
      ),
    );
  }
  Widget _builCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required List<Widget> children
}){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8, offset: const Offset(0, 5))]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 25, color: Colors.white,),
                const SizedBox(width: 10,),
                Text(label, style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            ),
            const SizedBox(height: 10,),
            ...children
          ],
        )
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onClick
}){
    return GestureDetector(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, ),),
          Icon(icon, color: Colors.white,)
        ],
      ),
    );
  }
}
