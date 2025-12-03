import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'view/LoginPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreen<LoginScreen, AuthModel> {
  @override
  Widget buildBody(BuildContext context, AuthModel viewModel) {
    return Stack(
      children: [
        // СЛОЙ 1: Задний фон (картинка на весь экран)
        Positioned.fill(
          child: Image.asset(
            'assets/images/doctor_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),

        // СЛОЙ 2: Контент по центру
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: LoginPage(),
          ),
        ),
      ],
    );
  }
}