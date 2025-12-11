import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Контроллеры
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  // Состояние: отправлен ли код?
  bool isCodeSent = false;

  // Ошибки полей
  String? usernameError;
  String? emailError;
  String? passwordError;
  String? phoneError;
  String? addressError;
  String? dobError;
  String? codeError;

  // --- ЛОГИКА ВАЛИДАЦИИ (Этап 1) ---
  bool validateStep1() {
    bool isValid = true;
    String? tempUsernameError;
    String? tempEmailError;
    String? tempPasswordError;
    String? tempPhoneError;
    String? tempAddressError;
    String? tempDobError;

    // 1. ФИО
    if (usernameController.text.trim().isEmpty) {
      tempUsernameError = "Введите ФИО";
      isValid = false;
    }

    // 2. Email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final email = emailController.text.trim();
    if (email.isEmpty) {
      tempEmailError = "Введите email";
      isValid = false;
    } else if (!emailRegex.hasMatch(email)) {
      tempEmailError = "Некорректный email";
      isValid = false;
    }

    // 3. Пароль
    if (passwordController.text.length < 6) {
      tempPasswordError = "Мин. 6 символов";
      isValid = false;
    }

    // 4. Телефон
    if (phoneNumberController.text.trim().isEmpty) {
      tempPhoneError = "Введите номер";
      isValid = false;
    }

    // 5. Адрес
    if (addressController.text.trim().isEmpty) {
      tempAddressError = "Введите адрес";
      isValid = false;
    }

    // 6. Дата рождения
    if (dateOfBirthController.text.isEmpty) {
      tempDobError = "Выберите дату";
      isValid = false;
    }

    setState(() {
      usernameError = tempUsernameError;
      emailError = tempEmailError;
      passwordError = tempPasswordError;
      phoneError = tempPhoneError;
      addressError = tempAddressError;
      dobError = tempDobError;
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
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
          // --- ЗАГОЛОВОК (ПРОСТО ТЕКСТ, БЕЗ ИКОНКИ) ---
          const Text(
            "Регистрация",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 30),

          // --- ПОЛЯ ВВОДА ---
          _buildRoundedField("Введите свое ФИО", controller: usernameController, error: usernameError, enabled: !isCodeSent),
          _buildRoundedField("Введите свою почту", controller: emailController, error: emailError, enabled: !isCodeSent),
          _buildRoundedField("Придумайте пароль", controller: passwordController, obscure: true, error: passwordError, enabled: !isCodeSent),
          _buildRoundedField("Введите свой номер телефона", controller: phoneNumberController, error: phoneError, enabled: !isCodeSent),
          _buildRoundedField("Введите свой адрес проживания", controller: addressController, error: addressError, enabled: !isCodeSent),
          _buildDateField(context, "Введите дату рождения", controller: dateOfBirthController, error: dobError, enabled: !isCodeSent),

          // --- ПОЛЕ КОДА ---
          if (isCodeSent)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildRoundedField(
                "Введите код для подтверждения почты",
                controller: codeController,
                error: codeError,
                isCodeField: true,
              ),
            ),

          const SizedBox(height: 25),

          // --- ЗОНА КНОПОК (РЯД) ---
          if (authModel.isLoading)
            const CircularProgressIndicator()
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Центрируем кнопки
              children: [

                // 1. КНОПКА "НАЗАД" (Появляется только на шаге 2)
                if (isCodeSent) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Белый фон для кнопки
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isCodeSent = false;
                          codeError = null;
                          codeController.clear();
                        });
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      tooltip: "Назад",
                    ),
                  ),
                  const SizedBox(width: 15), // Отступ между стрелкой и большой кнопкой
                ],

                // 2. ОСНОВНАЯ КНОПКА (ДАЛЕЕ / ЗАРЕГИСТРИРОВАТЬСЯ)
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCodeSent
                            ? const Color(0xFF55C748) // Зеленый
                            : const Color(0xFFE0E0E0), // Серый
                        foregroundColor: isCodeSent ? Colors.white : Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: isCodeSent
                              ? BorderSide.none
                              : const BorderSide(color: Colors.black54, width: 1),
                        ),
                      ),
                      onPressed: () async {
                        // --- ЛОГИКА "ДАЛЕЕ" ---
                        if (!isCodeSent) {
                          if (validateStep1()) {
                            final success = await authModel.sendOtpEmail(emailController.text.trim());
                            if (success) {
                              setState(() {
                                isCodeSent = true;
                              });
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(authModel.errorMessage ?? "Ошибка отправки")),
                                );
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Заполните поля корректно")),
                            );
                          }
                        }
                        // --- ЛОГИКА "ЗАРЕГИСТРИРОВАТЬСЯ" ---
                        else {
                          if (codeController.text.trim().isEmpty) {
                            setState(() => codeError = "Введите код");
                            return;
                          }

                          final isCodeValid = authModel.verifyCode(codeController.text.trim());

                          if (isCodeValid) {
                            final result = await authModel.register(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phoneNumber: phoneNumberController.text,
                              address: addressController.text,
                              dateOfBirth: dateOfBirthController.text,
                            );

                            if (result != null && context.mounted) {
                              context.go('/');
                            } else if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authModel.errorMessage ?? 'Ошибка регистрации')),
                              );
                            }
                          } else {
                            setState(() => codeError = "Неверный код");
                          }
                        }
                      },
                      child: Text(
                        isCodeSent ? "Зарегистрироваться" : "Далее",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              context.go('/login');
            },
            child: const Text(
              "У вас уже есть аккаунт? Войти",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // --- UI ПОЛЯ ---
  Widget _buildRoundedField(
      String hint, {
        required TextEditingController controller,
        bool obscure = false,
        String? error,
        bool isCodeField = false,
        bool enabled = true,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: enabled ? Colors.white : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: error != null ? Colors.red : Colors.grey.shade400,
                  width: 1,
                ),
                boxShadow: [
                  if (isCodeField)
                    BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 10)
                ]
            ),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              enabled: enabled,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 4),
              child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  // --- UI ДАТЫ ---
  Widget _buildDateField(
      BuildContext context,
      String hint, {
        required TextEditingController controller,
        String? error,
        bool enabled = true,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: enabled ? Colors.white : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: error != null ? Colors.red : Colors.grey.shade400,
                width: 1,
              ),
            ),
            child: TextField(
              controller: controller,
              readOnly: true,
              enabled: enabled,
              textAlign: TextAlign.center,
              onTap: enabled ? () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  controller.text = DateFormat('yyyy-MM-dd').format(picked);
                }
              } : null,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                suffixIcon: const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
              ),
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 4),
              child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}