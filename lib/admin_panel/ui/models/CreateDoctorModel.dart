import 'package:flutter/material.dart';
import '../../dto/DoctorRequestDto.dart';
import '../../rep/UserRepository.dart';

class CreateDoctorModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  // Контроллеры для полей ввода
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final specializationController = TextEditingController();

  // Для даты рождения
  DateTime? selectedDate;
  final dateController = TextEditingController(); // Для отображения даты текстом

  bool isLoading = false;
  String? errorMessage;

  // Метод выбора даты
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990), // Примерный год по умолчанию
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1976D2), // Medical Blue
              onPrimary: Colors.white,
              onSurface: Color(0xFF212121),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      // Форматируем для отображения и отправки: yyyy-MM-dd
      String formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      dateController.text = formattedDate;
      notifyListeners();
    }
  }

  // Метод регистрации
  Future<bool> register() async {
    if (!_validate()) return false;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final dto = DoctorRequestDto(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        specialization: specializationController.text.trim(),
        dateOfBirth: dateController.text, // Передаем строку yyyy-MM-dd
      );

      await _repository.registerDoctor(dto);
      return true; // Успех
    } catch (e) {
      errorMessage = "Ошибка регистрации: ${e.toString()}";
      // Убираем лишний текст ошибки, если он пришел от Dio
      if (errorMessage!.contains("Exception:")) {
        errorMessage = errorMessage!.replaceAll("Exception:", "").trim();
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool _validate() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        specializationController.text.isEmpty ||
        selectedDate == null) {
      errorMessage = "Пожалуйста, заполните все поля";
      notifyListeners();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    specializationController.dispose();
    dateController.dispose();
    super.dispose();
  }
}