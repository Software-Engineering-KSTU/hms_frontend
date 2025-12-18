import 'package:flutter/material.dart';
import 'package:hmsweb/auth/ui/view/LoginPage.dart';
import 'package:hmsweb/auth/ui/view/RegistrationPage.dart';

// Функция для вызова окна входа
void showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent, // Прозрачный, т.к. скругление внутри виджета
      insetPadding: const EdgeInsets.all(16), // Отступы от краев экрана
      child: const LoginPage(isDialog: true),
    ),
  );
}

// Функция для вызова окна регистрации
void showRegistrationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: const RegistrationPage(isDialog: true),
    ),
  );
}