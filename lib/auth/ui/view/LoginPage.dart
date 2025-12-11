import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Контроллеры теперь хранятся в состоянии (State) и не исчезают при перерисовке
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
    // Обязательно освобождаем память при закрытии экрана
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85), // Эффект стекла
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Авторизация",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),

          // Поля ввода
          _buildRoundedField("Введите ФИО пользователя", controller: usernameController),
          _buildRoundedField("Введите свой пароль", controller: passwordController, obscure: true),

          const SizedBox(height: 25),

          if (authModel.isLoading)
            const CircularProgressIndicator()
          else
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF55C748),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  // Убираем клавиатуру перед запросом
                  FocusScope.of(context).unfocus();

                  final result = await authModel.login(
                    usernameController.text,
                    passwordController.text,
                  );

                  if (result != null) {
                    if (context.mounted) context.go('/');
                  } else {
                    if (context.mounted) {
                      // Показываем сообщение об ошибке (SnackBar), поля при этом НЕ очистятся
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(authModel.errorMessage ?? 'Ошибка входа'),
                          backgroundColor: Colors.redAccent, // Красный цвет для ошибки
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Войти",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),

          const SizedBox(height: 20),

          const Text("Вы еще не зарегистрированы?", style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 5),

          GestureDetector(
            onTap: () {
              context.go('/registration');
            },
            child: const Text(
              "Регистрация",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedField(
      String hint, {
        required TextEditingController controller,
        bool obscure = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ),
    );
  }
}