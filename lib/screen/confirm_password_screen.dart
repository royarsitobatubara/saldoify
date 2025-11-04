import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/data/user_provider.dart';
import 'package:saldoify/screen/layouts/screen_layout.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final int id;
  final String name;
  final String password;
  const ConfirmPasswordScreen({super.key, required this.id, required this.name, required this.password});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPasswordScreen> {
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirmHandle() async{
    if (_passwordCtrl.text.toLowerCase() != widget.password.toLowerCase()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text(
              "Incorrect Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "The password you entered is wrong. Please try again.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    await UserPreferences.setDataInt('userId', widget.id);
    await UserPreferences.setDataBool('isLogin', true);
    if(!mounted)return;
    context.read<UserProvider>().loadAll();
    context.go('/splash');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: 'Validation Account',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your password",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordCtrl,
              obscureText: _obscure,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=>_confirmHandle(),
                child: const Text("Confirm"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
