import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/CreateDoctorModel.dart';

class CreateDoctorView extends StatelessWidget {
  const CreateDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    // Обязательно оборачиваем в ChangeNotifierProvider, чтобы модель жила в этом экране
    return ChangeNotifierProvider(
      create: (_) => CreateDoctorModel(),
      child: const _CreateDoctorContent(),
    );
  }
}

class _CreateDoctorContent extends StatelessWidget {
  const _CreateDoctorContent();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CreateDoctorModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Регистрация врача',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Новый специалист",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
            ),
            const SizedBox(height: 8),
            const Text(
              "Заполните данные для создания аккаунта врача.",
              style: TextStyle(color: Color(0xFF757575)),
            ),
            const SizedBox(height: 30),

            _buildField("Имя пользователя", model.usernameController, Icons.person_outline),
            _buildField("Email", model.emailController, Icons.email_outlined),
            _buildField("Пароль", model.passwordController, Icons.lock_outline, obscure: true),
            _buildField("Телефон", model.phoneController, Icons.phone_outlined),
            _buildField("Специализация", model.specializationController, Icons.medical_services_outlined),

            // Поле даты рождения
            GestureDetector(
              onTap: () => model.pickDate(context),
              child: AbsorbPointer(
                child: _buildField("Дата рождения", model.dateController, Icons.calendar_today_outlined),
              ),
            ),

            if (model.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  model.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: model.isLoading
                    ? null
                    : () async {
                  final success = await model.register();
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Врач успешно создан"), backgroundColor: Colors.green),
                    );
                    Navigator.pop(context); // Возвращаемся в список
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                child: model.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Создать аккаунт",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String hint, TextEditingController controller, IconData icon, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: Icon(icon, color: const Color(0xFF1976D2)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ),
    );
  }
}