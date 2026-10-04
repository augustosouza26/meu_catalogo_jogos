import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const double spacing = 16;

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3F51B5));
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        centerTitle: false,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
      ),
    );
  }
}
