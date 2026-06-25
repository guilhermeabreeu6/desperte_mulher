import 'package:flutter/material.dart';
import 'theme_notifier.dart';
import 'quick_exit.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, mode, __) => IconButton(
            tooltip: mode == ThemeMode.dark ? 'Modo claro' : 'Modo escuro',
            icon: Icon(
              mode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              final next =
                  mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              themeNotifier.value = next;
              saveThemePreference(next);
            },
          ),
        ),
        IconButton(
          tooltip: 'Saída rápida',
          icon: const Icon(Icons.exit_to_app),
          onPressed: quickExit,
        ),
      ],
    );
  }
}
