import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/data/database/user_service.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/screen/layouts/screen_layout.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _obscure = true;

  Future<void> _confirmHandle() async{
    try{
      final userId = await UserPreferences.getDataInt('userId');
      await editPassword(id: userId, newPassword: _passwordCtrl.text);
      if (!mounted) return;
      context.go('/feedback', extra: 'Password changed successfully');
    }catch(e){
      debugPrint('Terjadi Kesalahan pada _confirmHandle: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: 'Edit Password',
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
                onPressed: () => _confirmHandle(),
                child: const Text("Confirm"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
