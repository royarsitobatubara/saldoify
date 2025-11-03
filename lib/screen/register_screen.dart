import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saldoify/data/database/user_service.dart';
import 'package:saldoify/helpers/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool _hidePass = true;
  bool _hideConfirm = true;
  String? _errorMsg;

  Future<void> registerHandle() async {
    try {
      final result = await register(
        name: _username.text,
        password: _password.text,
      );

      if (result > 0) {
        if (!mounted) return;
        context.pop();
        return;
      }

      if (!mounted) return;
      setState(() {
        _errorMsg = "Failed to register, username may already exist";
      });

    } catch (e) {
      debugPrint('Failed to register: $e');
      if (!mounted) return;
      setState(() {
        _errorMsg = "Server error, please try again later";
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
                  Icons.person_add_alt_1_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),

                const Text(
                  "Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 35),

                _buildInputField(
                  controller: _username,
                  hint: "Username",
                  icon: Icons.person_outline_rounded,
                  obscure: false,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: _password,
                  hint: "Password",
                  icon: Icons.lock,
                  obscure: _hidePass,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() => _hidePass = !_hidePass);
                    },
                    child: Icon(
                      _hidePass ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: _confirmPass,
                  hint: "Confirm Password",
                  icon: Icons.lock_outline_rounded,
                  obscure: _hideConfirm,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() => _hideConfirm = !_hideConfirm);
                    },
                    child: Icon(
                      _hideConfirm ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),

                if (_errorMsg != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMsg!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    if (_password.text != _confirmPass.text) {
                      setState(() => _errorMsg = "Password tidak sama");
                      return;
                    }
                    await registerHandle();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => context.push('/login'),
                  child: const Text(
                    "Already have an account? Login",
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
