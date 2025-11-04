import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/models/user_model.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/helpers/app_colors.dart';
import 'package:saldoify/screen/layouts/screen_layout.dart';

class ListAccount extends StatefulWidget {
  const ListAccount({super.key});

  @override
  State<ListAccount> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ListAccount> {

  Future<void> _accontHandle({required int id, required String name, required String password}) async {
    try{
      final userId = await UserPreferences.getDataInt('userId');
      if(id == userId) return;
      if(!mounted)return;
      context.push('/confirm-account', extra: {
        'id': id,
        'name':name,
        'password': password
      });
    }catch(e){
      debugPrint('Terjadi kesalahan pada accoutnHandle: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if(!mounted)return;
      context.read<UserProvider>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: 'Swap Account',
      child: Selector<UserProvider, List<UserModel>>(
        selector: (_, prov) => prov.userList,
        builder: (_, users, __) {
          if (users.isEmpty) {
            return const Center(
              child: Text(
                "No accounts found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return GestureDetector(
                onTap: ()async=>await _accontHandle(id: user.id!,name: user.name, password: user.password),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 1,
                        color: Colors.black.withValues(alpha: .08),
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primary,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
