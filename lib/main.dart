// fileName: lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart'; // <--- Добавляем для типизации GoRouter
import 'package:hmsweb/http/HttpRequest.dart';
import 'package:hmsweb/GlobalStorage.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/AuthModel.dart';

// ИЗМЕНЕНИЕ 1: Импортируем весь файл, чтобы видеть функцию createRouter
import 'navigation/Navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  setUpDioHttpRequest();

  // 1. Создаем экземпляр модели авторизации
  final authModel = AuthModel();

  // 2. Проверяем статус при старте
  await authModel.onInitialization();

  // ИЗМЕНЕНИЕ 2: Создаем роутер, связывая его с authModel
  // Теперь роутер будет знать, когда пользователь вошел/вышел
  final appRouter = createRouter(authModel);

  runApp(
    ChangeNotifierProvider<AuthModel>.value(
      value: authModel,
      // ИЗМЕНЕНИЕ 3: Передаем созданный роутер в MyApp
      child: MyApp(router: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  // ИЗМЕНЕНИЕ 4: Принимаем роутер в конструкторе
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // ИЗМЕНЕНИЕ 5: Используем переданный роутер
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}