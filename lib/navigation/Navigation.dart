import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/%20clinic_contact_info/ui/ContactsModel.dart';
import 'package:hmsweb/%20clinic_contact_info/ui/ContactsScreen.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/base/view/CustomAppBar.dart';
import 'package:hmsweb/home/ui/HomeModel.dart';
import 'package:hmsweb/home/ui/HomeScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/doctor_list/DoctorListScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/doctor_list/DoctorListScreenModel.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/ui/LoginScreen.dart';
import 'package:hmsweb/auth/ui/RegistrationScreen.dart';
import 'package:hmsweb/auth/AuthModel.dart';

import '../doctor_appointment/dashboard/ui/DoctorDashboardScreen.dart';
import '../doctor_appointment/dashboard/ui/DoctorDashboardScreenModel.dart';
import '../patient_appointment/dashboard/ui/PatientDashboardScreen.dart';
import '../patient_appointment/dashboard/ui/PatientDashboardScreenModel.dart';

GoRoute buildRoute<T extends BaseScreenModel>({
  required String path,
  required Widget screen,
  required T Function(GoRouterState state) createModel,
  required bool useTransition,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {

      final model = createModel(state);
      model.initialize();

      final child =  ChangeNotifierProvider.value(
        value: model,
        child: screen,
      );

      if (!useTransition) {
        return MaterialPage(key: state.pageKey, child: child);
      }

      return CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {

          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      );
    },
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    buildRoute(
        path: '/doctor/dashboard',
        useTransition: true,
        screen: DoctorDashboardScreen(),
        createModel: (state) => DoctorDashboardScreenModel()),

    buildRoute(
        path: '/patient/doctors',
        useTransition: true,
        screen: DoctorListScreen(),
        createModel: (state) => DoctorListScreenModel()),

    GoRoute(
      path: '/patient/dashboard',
      builder: (context, state) => DoctorListScreen(),
      routes: [
        buildRoute<PatientDashboardScreenModel>(
          path: ':doctorId',
          useTransition: true,
          screen: PatientDashboardScreen(),
          createModel: (state) {
            final doctorId = state.pathParameters['doctorId'];
            return PatientDashboardScreenModel(idDoctor: doctorId!);
          },
        ),
      ],
    ),

    buildRoute(
      path: '/login',
      useTransition: true,
      screen: LoginScreen(),
      createModel: (sate) => AuthModel(),
    ),
    buildRoute(
      path: '/registration',
      useTransition: true,
      screen: RegistrationScreen(),
      createModel: (state) => AuthModel(),
    ),

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
            useTransition: false,
            screen: HomeScreen(),
            createModel: (state) => HomeModel()
        ),

        buildRoute(
            path: '/contacts',
            useTransition: false,
            screen: ContactsScreen(),
            createModel: (state) => ContactsModel()
        ),
      ],
    ),
  ],
);
