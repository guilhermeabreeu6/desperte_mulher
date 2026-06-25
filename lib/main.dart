import 'package:flutter/material.dart';
import 'package:desperte_mulher/login/login_page.dart';
import 'package:desperte_mulher/profile/profile_page.dart';
import 'Screens/quiz/quiz_page.dart';
import 'Screens/registration/register_page.dart';
import 'Screens/result/result_page.dart';
import 'common/app_routes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desperte Mulher',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B1FA2),
          primary: const Color(0xFF7B1FA2),
          secondary: const Color(0xFFE91E63),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F0FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7B1FA2),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7B1FA2),
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF7B1FA2),
            side: const BorderSide(color: Color(0xFF7B1FA2)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFF7B1FA2), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF7B1FA2),
        ),
      ),
      initialRoute: AppRoutes.loginPage,
      routes: {
        AppRoutes.loginPage: (_) => const LoginPage(),
        AppRoutes.profilePage: (_) => const ProfilePage(),
        AppRoutes.registerPage: (_) => const RegisterPage(),
        AppRoutes.quizPage: (_) => const QuizPage(),
        AppRoutes.resultPage: (_) => const ResultPage(),
      },
    );
  }
}
