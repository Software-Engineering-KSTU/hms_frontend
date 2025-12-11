import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'view/RegistrationPage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends BaseScreen<RegistrationScreen, AuthModel> {
  @override
  Widget buildBody(BuildContext context, AuthModel viewModel) {
    return Stack(
      children: [
        // СЛОЙ 1: Задний фон (Неподвижный)
        Positioned.fill(
          child: Image.asset(
            'assets/images/doctor_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),

        // СЛОЙ 2: Контент (Прокручиваемый)
        Center(
          child: SingleChildScrollView(
            // Отступы, чтобы на маленьких экранах было место сверху/снизу
            padding: const EdgeInsets.all(24.0),
            child: RegistrationPage(),
          ),
        ),
      ],
    );
  }
}