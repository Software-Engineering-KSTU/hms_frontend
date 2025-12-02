import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/base/view/CustomAppBar.dart';
import 'package:hmsweb/home/ui/HomeModel.dart';
import 'package:hmsweb/home/ui/HomeScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/doctor_list/DoctorListScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/doctor_list/DoctorListScreenModel.dart';
import 'package:provider/provider.dart';
import '../doctors_summary/ui/Doctor_summery.dart';
import '../errorpage/ui/Error404Page.dart';
import '../errorpage/ui/Error500Page.dart';
import 'package:hmsweb/auth/ui/LoginScreen.dart';  // Импорт LoginScreen
import 'package:hmsweb/auth/ui/RegistrationScreen.dart';  // Импорт RegistrationScreen
import 'package:hmsweb/auth/AuthModel.dart';  // Импорт AuthModel

import '../doctor_appointment/dashboard/ui/DoctorDashboardScreen.dart';
import '../doctor_appointment/dashboard/ui/DoctorDashboardScreenModel.dart';
import '../patient_appointment/dashboard/ui/PatientDashboardScreen.dart';
import '../patient_appointment/dashboard/ui/PatientDashboardScreenModel.dart';

GoRoute buildRoute<T extends BaseScreenModel>({
  required String path,
  required Widget screen,
  required T Function() createModel,
}) {
  return GoRoute(
    path: path,
    builder: (context, state) {

      final model = createModel();
      model.initialize();

      return ChangeNotifierProvider.value(
        value: model,
        child: screen,
      );
    },
  );
}

final GoRouter router = GoRouter(
  routes: [
    buildRoute(
        path: '/doctor/dashboard',
        screen: DoctorDashboardScreen(),
        createModel: () => DoctorDashboardScreenModel()),

    buildRoute(
        path: '/patient/doctors',
        screen: DoctorListScreen(),
        createModel: () => DoctorListScreenModel()),

    buildRoute(
        path: '/patient/dashboard',
        screen: PatientDashboardScreen(),
        createModel: () => PatientDashboardScreenModel()),

    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          appBar: const CustomAppBar(),
          body: child,
        );
      },
      routes: [
        buildRoute(
            path: '/',
            screen: HomeScreen(),
            createModel: () => HomeModel()
        ),
        buildRoute(
          path: '/login',
          screen: LoginScreen(),
          createModel: () => AuthModel(),
        ),
        buildRoute(
          path: '/registration',
          screen: RegistrationScreen(),
          createModel: () => AuthModel(),
        ),

      ],
    ),
  ],
);




}