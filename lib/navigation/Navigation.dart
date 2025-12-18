import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:hmsweb/clinic_contact_info/ui/ContactsModel.dart';
import 'package:hmsweb/clinic_contact_info/ui/ContactsScreen.dart';

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
import 'package:hmsweb/patient_appointment/dashboard/ui/PatientDashboardScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/PatientDashboardScreenModel.dart';
import 'package:hmsweb/doctors_resume/ui/DoctorResumeScreen.dart';
import 'package:hmsweb/doctors_resume/ui/DoctorResumeModel.dart';
import 'package:hmsweb/admin_panel/ui/view/AdminDashboardScreen.dart';
import 'package:hmsweb/admin_panel/ui/view/AdminUsersView.dart';
import 'package:hmsweb/admin_panel/ui/view/CreateDoctorView.dart';
import 'package:hmsweb/doctor_appointment/dashboard/ui/DoctorDashboardScreen.dart';
import 'package:hmsweb/doctor_appointment/dashboard/ui/DoctorDashboardScreenModel.dart';
import 'package:hmsweb/admin_panel/ui/models/AdminUsersModel.dart';

// Убедитесь, что этот файл существует, иначе закомментируйте
import 'package:hmsweb/admin_panel/ui/view/AdminDoctorResumeScreen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthModel authModel) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: authModel,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return child;
        },
        routes: [
          // ГЛАВНАЯ
          buildRoute(
            path: '/',
            screen: HomeScreen(),
            useTransition: false,
            createModel: (state) => HomeModel(),
          ),

          // ПАЦИЕНТ: СПИСОК ВРАЧЕЙ
          buildRoute(
            path: '/patient/doctors',
            screen: DoctorListScreen(),
            useTransition: false,
            createModel: (state) => DoctorListScreenModel(),
          ),

          // --- ИСПРАВЛЕННЫЙ МАРШРУТ (ЗАПИСЬ) ---
          // Мы не используем buildRoute, чтобы вручную передать doctorId в экран
          GoRoute(
            path: '/patient/dashboard/:doctorId',
            pageBuilder: (context, state) {
              // 1. Извлекаем ID из URL
              final doctorId = state.pathParameters['doctorId'] ?? "1";

              // 2. Создаем экран и модель
              return buildPageWithSlide(
                context: context,
                state: state,
                child: ChangeNotifierProvider(
                  // Передаем ID в модель
                  create: (_) => PatientDashboardScreenModel(idDoctor: doctorId),
                  child: CustomAppBarWrapper(
                    // Передаем ID в экран (ЭТО ГЛАВНОЕ ИСПРАВЛЕНИЕ)
                    child: PatientDashboardScreen(doctorId: doctorId),
                  ),
                ),
              );
            },
          ),
          // -------------------------------------

          // ПУБЛИЧНОЕ РЕЗЮМЕ
          buildRoute(
            path: '/doctor/resume/:doctorId',
            useTransition: true,
            screen: const DoctorResumeScreen(),
            createModel: (state) {
              final doctorId = state.pathParameters['doctorId'];
              return DoctorResumeModel(idDoctor: doctorId ?? "1");
            },
          ),

          // КОНТАКТЫ
          buildRoute(
            path: '/contacts',
            screen: const ContactsScreen(),
            useTransition: false,
            createModel: (state) => ContactsModel(),
          ),

          // КАБИНЕТ ВРАЧА
          buildRoute(
            path: '/doctor/dashboard',
            screen: DoctorDashboardScreen(),
            useTransition: false,
            createModel: (state) => DoctorDashboardScreenModel(),
          ),

          // --- АДМИН ПАНЕЛЬ ---

          GoRoute(
            path: '/admin/dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CustomAppBarWrapper(child: AdminDashboardScreen()),
            ),
          ),

          GoRoute(
            path: '/admin/users',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => AdminUsersModel(),
              child: const AdminUsersView(),
            ),
          ),

          GoRoute(
            path: '/admin/create-doctor',
            builder: (context, state) => const CreateDoctorView(),
          ),

          // МАРШРУТ С ОШИБКОЙ (Если AdminDoctorResumeScreen существует)
          GoRoute(
            path: '/admin/resume/:id',
            builder: (context, state) {
              final userIdStr = state.pathParameters['id'];
              final userId = int.tryParse(userIdStr ?? '0') ?? 0;
              return AdminDoctorResumeScreen(userId: userId);
            },
          ),

          // --- АВТОРИЗАЦИЯ ---

          buildRoute(
            path: '/login',
            useTransition: true,
            screen: const LoginScreen(),
          ),

          buildRoute(
            path: '/registration',
            useTransition: true,
            screen: const RegistrationScreen(),
          ),

          buildRoute(
            path: '/oops',
            screen: const Error500Page(),
            useTransition: true,
            createModel: (state) => ErrorScreenModel(),
          ),
        ],
      ),
    ],
  );
}

// ... HELPER FUNCTIONS ...

GoRoute buildRoute<M extends BaseScreenModel>({
  required String path,
  required Widget screen,
  M Function(GoRouterState state)? createModel,
  bool useTransition = false,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      Widget pageContent = CustomAppBarWrapper(child: screen);

      if (createModel != null) {
        pageContent = ChangeNotifierProvider<M>(
          create: (_) => createModel(state),
          child: pageContent,
        );
      }

      if (useTransition) {
        return buildPageWithSlide(
          context: context,
          state: state,
          child: pageContent,
        );
      } else {
        return NoTransitionPage(child: pageContent);
      }
    },
  );
}

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
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class CustomAppBarWrapper extends StatelessWidget {
  final Widget child;
  const CustomAppBarWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: child,
    );
  }
}