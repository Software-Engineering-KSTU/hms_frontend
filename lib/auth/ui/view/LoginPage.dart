import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'package:hmsweb/auth/dto/AuthDialogs.dart';

class LoginPage extends StatefulWidget {
  final bool isDialog;

  const LoginPage({super.key, this.isDialog = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    FocusScope.of(context).unfocus();

    final result = await authModel.login(
      usernameController.text,
      passwordController.text,
    );

    if (result != null) {
      if (mounted) {
        if (widget.isDialog) {
          Navigator.of(context).pop();
        } else {
        }
      }
    } else {
      if (mounted && authModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authModel.errorMessage!),
            backgroundColor: const Color(0xFFE53935),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Container(
      width: 420,
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.isDialog)
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.grey),
                  tooltip: "Закрыть",
                ),
            ],
          ),

          const Text(
            "Вход в систему",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),

          const SizedBox(height: 10),
          const Text(
            "Введите данные для доступа",
            style: TextStyle(color: Color(0xFF757575), fontSize: 14),
          ),

          const SizedBox(height: 30),

          _buildMedicalField("Имя пользователя", controller: usernameController, icon: Icons.person_outline),
          const SizedBox(height: 16),
          _buildMedicalField("Пароль", controller: passwordController, obscure: true, icon: Icons.lock_outline),

          const SizedBox(height: 30),

          if (authModel.isLoading)
            const CircularProgressIndicator(color: Color(0xFF1976D2))
          else
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.blue.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _handleLogin,
                child: const Text(
                  "Войти",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Нет аккаунта? ", style: TextStyle(color: Color(0xFF757575))),
              GestureDetector(
                onTap: () {
                  if (widget.isDialog) {
                    Navigator.pop(context);
                    showRegistrationDialog(context);
                  }
                },
                child: const Text(
                  "Регистрация",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalField(
      String hint, {
        required TextEditingController controller,
        bool obscure = false,
        IconData? icon,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Color(0xFF212121)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
          prefixIcon: Icon(icon, color: const Color(0xFF1976D2), size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}