import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hmsweb/http/HttpRequest.dart';

import 'navigation/Navigation.dart' show router;

void main() async {
  usePathUrlStrategy();
  setUpDioHttpRequest();

  runApp(const MyApp());

  await flutterStorage.write(key: 'accessToken', value: 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbGl5YS5zYWdhdCIsImlhdCI6MTc2NDc5MzQ1MywiZXhwIjoxNzY1Mzk4MjUzfQ.2Gtw-JGevz4oCcPTBgAyc_uwHW6nmerhQL6MOAk5ZOqj2Fc7PmbLLkf8sD5ViWc26jWS70Cr3sWjEYYZlK1sMw');

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}