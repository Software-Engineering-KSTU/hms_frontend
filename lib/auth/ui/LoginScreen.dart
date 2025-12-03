import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'view/LoginPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// class _LoginScreenState extends BaseScreen<LoginScreen, AuthModel> {
//   @override
//   Widget buildBody(BuildContext context, AuthModel viewModel) {
//     return Scaffold(  // Добавляем Scaffold для body
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: LoginPage(),
//         ),
//       ),
//     );
//   }
// }

class _LoginScreenState extends BaseScreen<LoginScreen, AuthModel> {
  @override
  Widget buildBody(BuildContext context, AuthModel viewModel) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}