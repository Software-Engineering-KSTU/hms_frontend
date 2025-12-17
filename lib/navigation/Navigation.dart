import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/doctors_resume/ui/DoctorResumeScreen.dart';
import 'package:provider/provider.dart';

// Твои импорты
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
import 'package:hmsweb/auth/ui/LoginScreen.dart';
import 'package:hmsweb/auth/ui/RegistrationScreen.dart';
import 'package:hmsweb/auth/AuthModel.dart';

import '../doctor_appointment/dashboard/ui/DoctorDashboardScreen.dart';
import '../doctor_appointment/dashboard/ui/DoctorDashboardScreenModel.dart';
import '../doctors_resume/ui/DoctorResumeModel.dart';
import '../errorpage/ui/Error404Page.dart';
import '../patient_appointment/dashboard/ui/PatientDashboardScreen.dart';
import '../patient_appointment/dashboard/ui/PatientDashboardScreenModel.dart';

import 'package:hmsweb/admin_panel/ui/view/AdminUsersView.dart';
import 'package:hmsweb/admin_panel/ui/AdminUsersModel.dart';

// --- МЕТОД BUILD ROUTE ---
GoRoute buildRoute<T extends BaseScreenModel>({
  required String path,
  required Widget screen,
  required T Function(GoRouterState state) createModel,
  bool useTransition = true,
  bool isBack = false, // true = свайп слева, false = свайп справа
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      final model = createModel(state);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        model.initialize();
      });
      final child = ChangeNotifierProvider.value(value: model, child: screen);

      if (!useTransition) {
        return NoTransitionPage(child: child);
      }

      return buildPageWithSlide(
        context: context,
        state: state,
        child: child,
        isBack: isBack,
      );
    },
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthModel authModel) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: authModel,

    // --- ЛОГИКА ПЕРЕНАПРАВЛЕНИЯ (REDIRECT) ---
    redirect: (context, state) {
      final isLoggedIn = authModel.isAuthenticated;
      final role = authModel.role;

      // Куда пользователь пытается перейти
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/registration';
      final isGoingToAdmin = state.matchedLocation.startsWith('/admin');

      // 1. Если не авторизован и пытается зайти в админку -> на логин
      if (!isLoggedIn && isGoingToAdmin) {
        return '/login';
      }


      if (isLoggedIn && (isGoingToLogin || isGoingToRegister || state.matchedLocation == '/')) {


        if (role == 'ADMIN') {
          return '/admin/users';
        }

        if (role == 'DOCTOR') return '/doctor/dashboard';
      }


      return null;
    },

    errorPageBuilder: (context, state) {
      return const MaterialPage(key: ValueKey('error'), child: Error404Page());
    },
    routes: [
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
            useTransition: true,
            isBack: true,
            screen: HomeScreen(),
            createModel: (state) => HomeModel(),
          ),



          buildRoute(
            path: '/contacts',
            useTransition: true,
            screen: ContactsScreen(),
            createModel: (state) => ContactsModel(),
          ),

          buildRoute(
            path: '/doctor/dashboard',
            useTransition: true,
            screen: DoctorDashboardScreen(),
            createModel: (state) => DoctorDashboardScreenModel(),
          ),

          buildRoute(
            path: '/patient/doctors',
            useTransition: true,
            screen: DoctorListScreen(),
            createModel: (state) => DoctorListScreenModel(),
          ),
          buildRoute(
            path: '/admin/users',
            useTransition: true,
            screen: const AdminUsersView(),
            createModel: (state) => AdminUsersModel(),
          ),

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

          GoRoute(
            path: '/doctor/resume',
            builder: (context, state) => DoctorListScreen(),
            routes: [
              buildRoute<DoctorResumeModel>(
                path: ':doctorId',
                useTransition: true,
                screen: DoctorResumeScreen(),
                createModel: (state) {
                  final doctorId = state.pathParameters['doctorId'];
                  return DoctorResumeModel(idDoctor: doctorId!);
                },
              ),
            ],
          ),


          buildRoute(
            path: '/login',
            useTransition: true,
            screen: LoginScreen(),
            createModel: (state) => authModel,
          ),

          buildRoute(
            path: '/registration',
            useTransition: true,
            screen: RegistrationScreen(),
            createModel: (state) => authModel,
          ),


          buildRoute(
            path: '/oops',
            screen: Error500Page(),
            useTransition: true,
            createModel: (state) => ErrorScreenModel(),
          ),
        ],
      ),
    ],
  );
}

// --- ФУНКЦИЯ АНИМАЦИИ ---
CustomTransitionPage buildPageWithSlide({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool isBack = false,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = Offset(isBack ? -1.0 : 1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOutCubic;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
