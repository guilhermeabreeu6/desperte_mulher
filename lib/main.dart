import 'package:flutter/material.dart';
import 'package:troca_contexto/login/login_page.dart';
import 'package:troca_contexto/profile/profile_page.dart';

import 'Screens/quiz/quiz_page.dart';
import 'Screens/registration/register_page.dart';
import 'Screens/result/result_page.dart';
import 'common/app_routes.dart';

void main() {
  runApp(createMaterialApp());
}

Widget createMaterialApp() {
  return MaterialApp(
    initialRoute: AppRoutes.loginPage,
    routes: {
      AppRoutes.loginPage: (_) => LoginPage(),
      AppRoutes.profilePage: (_) => ProfilePage(),
      AppRoutes.registerPage: (_) => const RegisterPage(),
      AppRoutes.quizPage: (_) => const QuizPage(),
      AppRoutes.resultPage: (_) => const ResultPage(),
    },
  );
}
