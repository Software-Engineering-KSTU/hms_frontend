import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/auth/rep/AuthRep.dart';
import 'package:hmsweb/auth/dto/AuthDto.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:dio/dio.dart';
import 'package:hmsweb/GlobalStorage.dart';

class AuthModel extends BaseScreenModel {
  final _rep = AuthRep();

  bool isLoading = false;
  String? errorMessage;
  String? _generatedCode;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

// Функция для проверки токена в хранилище и обновления статуса
  Future<void> _checkAuthStatus() async {
    final token = await flutterStorage.read(key: 'accessToken');
    final wasAuthenticated = _isAuthenticated;
    _isAuthenticated = token != null;

    // Вызываем notifyListeners только если статус изменился.
    if (wasAuthenticated != _isAuthenticated) {
      notifyListeners();
    }
  }


// --- LOGIN (ИСПРАВЛЕННЫЙ) ---
  Future<AuthDto?> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _rep.login(username: username, password: password);

      // В AuthRep токены должны быть сохранены до того, как результат вернется.
      if (result != null) {
        // Обновляем статус после успешного входа
        await _checkAuthStatus();
      }

      return result;
    } on DioException catch (e) {
      errorMessage = "Неверный ФИО или пароль";
      return null;
    } catch (e) {
      errorMessage = "Неизвестная ошибка";
      return null;
    } finally {
      isLoading = false;
      // notifyListeners() здесь нужен только для обновления isLoading,
      // но он может вызвать мерцание. Мы оставим его, чтобы обновить isLoading.
      notifyListeners();
    }
  }

// --- LOGOUT (ИСПРАВЛЕННЫЙ) ---
  Future<void> logout() async {
    await flutterStorage.delete(key: 'accessToken');
    await flutterStorage.delete(key: 'refreshToken');
    print("🚪 Токены удалены (Выход)");

    // Вместо ручного обновления, вызываем проверочную функцию.
    // Это гарантирует, что статус обновится на основе пустого хранилища.
    await _checkAuthStatus();
  }

  // --- SEND EMAIL (без изменений) ---
  Future<bool> sendOtpEmail(String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    // ... остальной код sendOtpEmail
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

  // --- VERIFY CODE (без изменений) ---
  bool verifyCode(String inputCode) {
    if (_generatedCode == inputCode.trim()) {
      return true;
    } else {
      errorMessage = "Неверный код подтверждения";
      notifyListeners();
      return false;
    }
  }

  // --- REGISTER (ИСПРАВЛЕННЫЙ) ---
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
      final result = await _rep.patientRegister(
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        address: address,
        dateOfBirth: dateOfBirth,
      );

      // Если после регистрации сервер сразу возвращает токен (авто-вход)
      if (result != null) {
        // Здесь токены должны быть сохранены в AuthRep

        // Обновляем статус после успешной регистрации
        await _checkAuthStatus();
      }

      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        errorMessage = "Пользователь с таким именем или почтой уже существует!";
      } else {
        errorMessage = "Ошибка сервера: ${e.response?.statusCode}. Попробуйте позже.";
      }
      return null;
    } catch (e) {
      errorMessage = "Произошла ошибка: $e";
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> onInitialization() async {
    // Проверяем статус при старте приложения
    await _checkAuthStatus();
  }
}