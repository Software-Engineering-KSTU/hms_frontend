import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'package:hmsweb/auth/dto/AuthDialogs.dart';

class RegistrationPage extends StatefulWidget {
  final bool isDialog;
  const RegistrationPage({super.key, this.isDialog = false});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool isCodeSent = false;

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? phoneError;
  String? addressError;
  String? dobError;
  String? codeError;

  bool validateStep1() {
    bool isValid = true;
    if (usernameController.text.isEmpty) isValid = false;
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Container(
      width: 480,
      constraints: const BoxConstraints(maxHeight: 700),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 25),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isCodeSent
                  ? IconButton(
                onPressed: () => setState(() {
                  isCodeSent = false;
                }),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1976D2)),
              )
                  : const SizedBox(width: 40),
              const Text(
                "Регистрация",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              if (widget.isDialog)
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.grey),
                )
              else
                const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMedicalField("ФИО", controller: usernameController, icon: Icons.person_outline, enabled: !isCodeSent),
                  _buildMedicalField("Email", controller: emailController, icon: Icons.email_outlined, enabled: !isCodeSent),
                  _buildMedicalField("Пароль", controller: passwordController, obscure: true, icon: Icons.lock_outline, enabled: !isCodeSent),
                  _buildMedicalField("Телефон", controller: phoneNumberController, icon: Icons.phone_outlined, enabled: !isCodeSent),
                  _buildMedicalField("Адрес", controller: addressController, icon: Icons.home_outlined, enabled: !isCodeSent),
                  _buildDateField(context, "Дата рождения", controller: dateOfBirthController, enabled: !isCodeSent),
                  if (isCodeSent)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          const Text("Мы отправили код на ваш Email", style: TextStyle(color: Colors.green)),
                          const SizedBox(height: 10),
                          _buildMedicalField("Код подтверждения", controller: codeController, icon: Icons.security, isCodeField: true),
                          if (codeError != null) Text(codeError!, style: const TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (authModel.isLoading)
            const CircularProgressIndicator(color: Color(0xFF1976D2))
          else
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCodeSent ? const Color(0xFF43A047) : const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () async {
                  if (!isCodeSent) {
                    final success = await authModel.sendOtpEmail(emailController.text.trim());
                    if (success) setState(() => isCodeSent = true);
                  } else {
                    if (authModel.verifyCode(codeController.text.trim())) {
                      final result = await authModel.register(
                        username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phoneNumber: phoneNumberController.text,
                        address: addressController.text,
                        dateOfBirth: dateOfBirthController.text,
                      );
                      if (result != null && mounted) {
                        Navigator.pop(context);
                      }
                    } else {
                      setState(() => codeError = "Неверный код");
                    }
                  }
                },
                child: Text(
                  isCodeSent ? "Подтвердить и войти" : "Продолжить",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              if (widget.isDialog) {
                Navigator.pop(context);
                showLoginDialog(context);
              }
            },
            child: const Text(
              "Уже есть аккаунт? Войти",
              style: TextStyle(color: Color(0xFF1976D2), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalField(String hint, {required TextEditingController controller, bool obscure = false, IconData? icon, bool enabled = true, bool isCodeField = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFF5F7FA) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: isCodeField ? Border.all(color: const Color(0xFF43A047)) : Border.all(color: Colors.transparent),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF1976D2), size: 20) : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, String hint, {required TextEditingController controller, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFF5F7FA) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          readOnly: true,
          enabled: enabled,
          onTap: enabled
              ? () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              controller.text = DateFormat('yyyy-MM-dd').format(picked);
            }
          }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF1976D2), size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ),
    );
  }
}