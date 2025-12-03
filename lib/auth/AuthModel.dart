import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/auth/rep/AuthRep.dart';
import 'package:hmsweb/auth/dto/AuthDto.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:dio/dio.dart'; // <--- ОБЯЗАТЕЛЬНО ДОБАВИТЬ ЭТОТ ИМПОРТ

class AuthModel extends BaseScreenModel {
  final _rep = AuthRep();

  bool isLoading = false;
  String? errorMessage;
  String? _generatedCode;

// --- LOGIN ---
  Future<AuthDto?> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      return await _rep.login(username: username, password: password);
    } catch (e) {
      // Здесь мы перехватываем любую ошибку и ставим понятное сообщение
      // Вместо технических деталей DioException
      errorMessage = "Неверный ФИО или пароль";
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- SEND EMAIL ---
  Future<bool> sendOtpEmail(String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final code = (Random().nextInt(9000) + 1000).toString();
    _generatedCode = code;

    print("--------------------------------------------------");
    print(">>> КОД ПОДТВЕРЖДЕНИЯ ДЛЯ $email: $code <<<");
    print("--------------------------------------------------");

    try {
      String smtpHost = 'localhost';
      if (!kIsWeb && Platform.isAndroid) {
        smtpHost = '10.0.2.2';
      }

      final smtpServer = SmtpServer(
        smtpHost,
        port: 1025,
        ignoreBadCertificate: true,
      );

      final message = Message()
        ..from = const Address('noreply@hms.com', 'HMS Registration')
        ..recipients.add(email)
        ..subject = 'Код подтверждения регистрации'
        ..text = 'Ваш код подтверждения: $code';

      await send(message, smtpServer);
      return true;

    } catch (e) {
      print('ОШИБКА ОТПРАВКИ MAILHOG: $e');
      errorMessage = "Mailhog недоступен, но код в консоли (Демо режим)";
      return true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- VERIFY CODE ---
  bool verifyCode(String inputCode) {
    if (_generatedCode == inputCode.trim()) {
      return true;
    } else {
      errorMessage = "Неверный код подтверждения";
      notifyListeners();
      return false;
    }
  }

  // --- REGISTER (С ОБРАБОТКОЙ ОШИБКИ 409) ---
  Future<AuthDto?> register({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      return await _rep.patientRegister(
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        address: address,
        dateOfBirth: dateOfBirth,
      );
    } on DioException catch (e) {
      // Ловим специфические ошибки сервера
      if (e.response?.statusCode == 409) {
        // 409 Conflict - Пользователь уже существует
        errorMessage = "Пользователь с таким именем или почтой уже существует!";
      } else {
        // Любые другие ошибки сервера
        errorMessage = "Ошибка сервера: ${e.response?.statusCode}. Попробуйте позже.";
      }
      return null;
    } catch (e) {
      // Ловим остальные ошибки (например, нет интернета)
      errorMessage = "Произошла ошибка: $e";
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> onInitialization() async {}
}