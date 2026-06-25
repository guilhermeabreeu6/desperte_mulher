import 'package:flutter/material.dart';
import 'package:desperte_mulher/login/login_page.dart';
import 'package:desperte_mulher/profile/profile_page.dart';
import 'Screens/quiz/quiz_page.dart';
import 'Screens/registration/register_page.dart';
import 'Screens/result/result_page.dart';
import 'common/app_routes.dart';
import 'common/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadThemePreference();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Desperte Mulher',
        themeMode: mode,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        initialRoute: AppRoutes.loginPage,
        routes: {
          AppRoutes.loginPage: (_) => const LoginPage(),
          AppRoutes.profilePage: (_) => const ProfilePage(),
          AppRoutes.registerPage: (_) => const RegisterPage(),
          AppRoutes.quizPage: (_) => const QuizPage(),
          AppRoutes.resultPage: (_) => const ResultPage(),
        },
      ),
    );
  }
}

ThemeData _buildLightTheme() {
  return ThemeData(
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
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7B1FA2),
      primary: const Color(0xFFCE93D8),
      secondary: const Color(0xFFF48FB1),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
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
        foregroundColor: const Color(0xFFCE93D8),
        side: const BorderSide(color: Color(0xFFCE93D8)),
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
        borderSide: BorderSide(color: Color(0xFFCE93D8), width: 2),
      ),
      filled: true,
      fillColor: Color(0xFF2C2C2C),
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFF2C2C2C),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFFCE93D8),
    ),
  );
}
