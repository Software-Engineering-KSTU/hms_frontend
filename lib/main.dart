import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hmsweb/http/HttpRequest.dart';

import 'navigation/Navigation.dart' show router;

void main() async {
  usePathUrlStrategy();
  setUpDioHttpRequest();

  runApp(const MyApp());

  final token = await flutterStorage.read(key: 'accessToken');

  print('main token: $token');

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext cowntext) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }

}