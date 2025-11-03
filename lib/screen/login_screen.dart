import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/data/database/user_service.dart';
import 'package:saldoify/data/user_preferences.dart';
import 'package:saldoify/helpers/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _hidePass = true;
  String _message = '';

  Future<void> loginHandle() async {
    try {
      final result = await login(name: _name.text, password: _password.text);
      if (result >= 1) {
        await UserPreferences.setDataInt('userId', result);
        await UserPreferences.setDataBool('isLogin', true);
        if (!mounted) return;
        context.go('/home');
        return;
      }
      if (!mounted) return;
      setState(() {
        _message = "Name or password is wrong";
      });

    } catch (e) {
      debugPrint('Failed to login: $e');
      if (!mounted) return;
      setState(() {
        _message = "Server error, please try again later";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Log in to continue managing your money",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14
                  ),
                ),

                const SizedBox(height: 35),

                _buildInputField(
                  controller: _name,
                  hint: "Name",
                  icon: Icons.person,
                  obscure: false,
                ),

                const SizedBox(height: 20),

                _buildInputField(
                    controller: _password,
                    hint: "Password",
                    icon: Icons.lock,
                    obscure: _hidePass,
                    suffix: GestureDetector(
                      onTap: (){
                        setState(() => _hidePass = !_hidePass);
                      },
                      child: Icon(
                        _hidePass ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: Colors.black54,
                      ),
                    )
                ),
                if(_message.trim().isNotEmpty)
                  Text(_message, textAlign: TextAlign.start ,style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async => await loginHandle(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: ()=>context.push('/register'),
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
    Widget? suffix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          icon: Icon(icon, size: 22, color: Colors.black87),
          suffixIcon: suffix,
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
