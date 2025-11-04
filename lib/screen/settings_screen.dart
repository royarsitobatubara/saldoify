import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/database/db_helper.dart';
import 'package:saldoify/data/database/transaction_service.dart';
import 'package:saldoify/data/database/user_service.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';

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
          backgroundColor: AppColors.foreign,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, textAlign: TextAlign.center),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.help_outline_rounded,
                size: 120,
                color: Colors.amber,
              ),
              SizedBox(height: 10),
              Text(
                "This action cannot be undone.",
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 25),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onSubmit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              child: const Text("Submit"),
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
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [

              _buildCard(context: context, icon: Icons.person, label: 'Account', children: [
                _buildMenuItem(context: context, label: 'Edit Password', icon: Icons.edit, onClick: ()=>context.push('/edit-password')),
                _buildMenuItem(context: context, label: 'Logout', icon: Icons.login, onClick: ()async{
                  await UserPreferences.deleteIsLogin();
                  if(!context.mounted)return;
                  context.go('/splash');
                  context.read<UserProvider>().loadAll();
                }),
                _buildMenuItem(context: context, label: 'Swap account', icon: Icons.swap_horiz_sharp, onClick: ()async{
                  if(!context.mounted)return;
                  context.push('/list-account');
                }),
              ]),

              _buildCard(
                context: context,
                label: "Storage",
                icon: Icons.storage_rounded,
                children: [
                  _buildMenuItem(
                    context: context,
                    icon: Icons.delete_outline_rounded,
                    label: "Delete transaction",
                    onClick: () => showConfirmDialog(
                      context: context,
                      title: "Delete all transactions?",
                      onSubmit: () async {
                        await deleteTransaction();
                        if (!context.mounted) return;
                        context.read<UserProvider>().loadAllTransactions();
                        context.read<UserProvider>().loadTransactions();
                      },
                    ),
                  ),

                  const Divider(color: Colors.white24, height: 25),

                  _buildMenuItem(
                    context: context,
                    icon: Icons.remove_circle_outline,
                    label: "Delete account",
                    onClick: () => showConfirmDialog(
                      context: context,
                      title: "Delete account permanently?",
                      onSubmit: () async {
                        await deleteUser();
                        await deleteTransaction();
                        await UserPreferences.deleteIsLogin();
                        if (!context.mounted) return;
                        context.read<UserProvider>().loadAll();
                        context.go('/splash');
                      },
                    ),
                  ),

                  const Divider(color: Colors.white24, height: 25),

                  _buildMenuItem(
                    context: context,
                    icon: Icons.cleaning_services_outlined,
                    label: "Clear app data",
                    onClick: () => showConfirmDialog(
                      context: context,
                      title: "Reset application data?",
                      onSubmit: () async {
                        await DBHelper().deleteDatabaseFile();
                        await UserPreferences.deleteData();
                        if (!context.mounted) return;
                        context.read<UserProvider>().loadAllTransactions();
                        context.read<UserProvider>().loadTransactions();
                        context.go('/splash');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 28, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
