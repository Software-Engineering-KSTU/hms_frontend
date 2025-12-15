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

// УБРАЛИ import jwt_decoder, он больше не нужен

class AuthModel extends BaseScreenModel {
  final _rep = AuthRep();

  bool isLoading = false;
  String? errorMessage;
  String? _generatedCode;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String? _role;
  String? get role => _role;

  // --- ПРОВЕРКА СТАТУСА (при старте приложения) ---
  Future<void> _checkAuthStatus() async {
    final token = await flutterStorage.read(key: 'accessToken');
    final savedRole = await flutterStorage.read(key: 'role'); // Читаем сохраненную роль

    final wasAuthenticated = _isAuthenticated;
    _isAuthenticated = token != null;

    // Если мы авторизованы, восстанавливаем роль в оперативную память
    if (_isAuthenticated) {
      _role = savedRole;
      print(">>> СТАТУС ВОССТАНОВЛЕН. ТЕКУЩАЯ РОЛЬ: $_role");
    }

    // Уведомляем интерфейс, если статус изменился
    if (wasAuthenticated != _isAuthenticated) {
      notifyListeners();
    }
  }


  // --- LOGIN ---
  Future<AuthDto?> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _rep.login(username: username, password: password);

      if (result != null) {
        // 1. Берем роль из ответа сервера (т.к. мы обновили AuthDto)
        _role = result.role;
        print(">>> ВЫ ВОШЛИ КАК: $_role");

        // 2. Сохраняем роль в память телефона (чтобы не пропала при перезагрузке)
        await flutterStorage.write(key: 'role', value: _role);

        // 3. Обновляем статус
        await _checkAuthStatus();
      }

      return result;
    } on DioException catch (e) {
      errorMessage = "Неверный ФИО или пароль";
      return null;
    } catch (e) {
      errorMessage = "Неизвестная ошибка: $e";
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- LOGOUT ---
  Future<void> logout() async {
    // Удаляем всё: токены и роль
    await flutterStorage.delete(key: 'accessToken');
    await flutterStorage.delete(key: 'refreshToken');
    await flutterStorage.delete(key: 'role');

    _role = null;
    print("🚪 Токены и роль удалены (Выход)");

    await _checkAuthStatus();
  }

  // --- REGISTER ---
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

      if (result != null) {
        // Если регистрация прошла успешно и сервер вернул токены с ролью
        _role = result.role;
        await flutterStorage.write(key: 'role', value: _role);
        print(">>> РЕГИСТРАЦИЯ УСПЕШНА. РОЛЬ: $_role");

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

  // --- SEND EMAIL (без изменений) ---
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

  @override
  Future<void> onInitialization() async {
    // Проверяем статус при старте приложения
    await _checkAuthStatus();
  }
}