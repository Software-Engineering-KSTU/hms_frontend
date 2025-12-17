import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/CreateDoctorModel.dart'; // Или просто ../CreateDoctorModel.dart в зависимости от вашей структуры

// Константы стиля (дублируем или выносим в отдельный файл стилей)
class MedicalColors {
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color background = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF212121);
  static const Color textGrey = Color(0xFF757575);
  static const Color white = Colors.white;
}

class CreateDoctorView extends StatelessWidget {
  const CreateDoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateDoctorModel(),
      child: const _CreateDoctorContent(),
    );
  }
}

class _CreateDoctorContent extends StatelessWidget {
  const _CreateDoctorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CreateDoctorModel>();

    return Scaffold(
      backgroundColor: MedicalColors.background,
      appBar: AppBar(
        title: const Text(
          'Регистрация врача',
          style: TextStyle(color: MedicalColors.textDark, fontWeight: FontWeight.bold),
        ),
        backgroundColor: MedicalColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: MedicalColors.textDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Заголовок формы (опционально)
            const SizedBox(height: 10),

            // Поле: Имя пользователя
            _buildInputField(
              controller: model.usernameController,
              label: 'Имя пользователя (Login)',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),

            // Поле: Email
            _buildInputField(
              controller: model.emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Поле: Пароль
            _buildInputField(
              controller: model.passwordController,
              label: 'Пароль',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),

            // Поле: Специализация
            _buildInputField(
              controller: model.specializationController,
              label: 'Специализация (например, Хирург)',
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 16),

            // Поле: Телефон
            _buildInputField(
              controller: model.phoneController,
              label: 'Номер телефона',
              icon: Icons.phone_outlined,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Поле: Дата рождения
            GestureDetector(
              onTap: () => model.pickDate(context),
              child: AbsorbPointer(
                child: _buildInputField(
                  controller: model.dateController,
                  label: 'Дата рождения',
                  icon: Icons.calendar_today_outlined,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Отображение ошибки
            if (model.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        model.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            // Кнопка регистрации
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: model.isLoading
                    ? null
                    : () async {
                  final success = await model.register();
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Врач успешно зарегистрирован'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context, true); // Возвращаемся назад с результатом true
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MedicalColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Pill shape
                  ),
                  elevation: 2,
                ),
                child: model.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Зарегистрировать',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Белый текст
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: MedicalColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: MedicalColors.textGrey),
          prefixIcon: Icon(icon, color: MedicalColors.primaryBlue),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}