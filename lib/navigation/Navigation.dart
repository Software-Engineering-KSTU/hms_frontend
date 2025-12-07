import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/%20clinic_contact_info/ui/ContactsModel.dart';
import 'package:hmsweb/%20clinic_contact_info/ui/ContactsScreen.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/base/view/CustomAppBar.dart';
import 'package:hmsweb/errorpage/ui/Error500Page.dart';
import 'package:hmsweb/errorpage/ui/ErrorScreenModel.dart';
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
import '../errorpage/ui/Error404Page.dart';
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
    builder: (context, state) {
      final model = createModel(state);
      model.initialize();

      return ChangeNotifierProvider.value(value: model, child: screen);
    },
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) {
    return const MaterialPage(key: ValueKey('error'), child: Error404Page());
  },
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

    buildRoute(
      path: '/oops',
      screen: Error500Page(),
      useTransition: true,
      createModel: (state) => ErrorScreenModel(),
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
