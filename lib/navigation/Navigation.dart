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
      // Если модель глобальная (как authModel), initialize может вызываться лишний раз,
      // но это безопасно, так как мы проверяем статус внутри.
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

// --- ГЛАВНОЕ ИЗМЕНЕНИЕ: Теперь это функция, принимающая AuthModel ---
GoRouter createRouter(AuthModel authModel) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',

    // --- МАГИЯ: Роутер обновляется при изменении AuthModel ---
    refreshListenable: authModel,

    // --------------------------------------------------------
    errorPageBuilder: (context, state) {
      return const MaterialPage(key: ValueKey('error'), child: Error404Page());
    },
    routes: [
      // --- ОБОЛОЧКА (SHELL) ---
      // Всё, что внутри этого списка routes, будет иметь CustomAppBar
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: const CustomAppBar(), // <--- Меню обновится автоматически
            body: child,
          );
        },
        routes: [
          // 1. ГЛАВНАЯ
          buildRoute(
            path: '/',
            useTransition: true,
            isBack: true,
            screen: HomeScreen(),
            createModel: (state) => HomeModel(),
          ),

          // 2. ВСЕ ОСТАЛЬНЫЕ СТРАНИЦЫ
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

          // --- ВАЖНО: Используем переданную authModel, а не создаем новую ---
          buildRoute(
            path: '/login',
            useTransition: true,
            screen: LoginScreen(),
            createModel: (state) => authModel, // <--- Глобальная модель
          ),

          buildRoute(
            path: '/registration',
            useTransition: true,
            screen: RegistrationScreen(),
            createModel: (state) => authModel, // <--- Глобальная модель
          ),

          // ----------------------------------------------------------------
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
