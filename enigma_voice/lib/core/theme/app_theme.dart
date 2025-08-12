import 'package:flutter/material.dart';

class AppTheme {
  static const Color _mystBlack = Color(0xFF0B0C10);
  static const Color _mystGrey = Color(0xFF1F2833);
  static const Color _mystTeal = Color(0xFF66FCF1);
  static const Color _mystGreen = Color(0xFF45A29E);

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _mystTeal,
        brightness: Brightness.dark,
        primary: _mystTeal,
        secondary: _mystGreen,
        surface: _mystGrey,
      ),
      scaffoldBackgroundColor: _mystBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: _mystGrey,
        foregroundColor: _mystTeal,
        elevation: 0,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: 'CrimsonPro',
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF12151A),
        border: OutlineInputBorder(),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _mystTeal,
        foregroundColor: Colors.black,
      ),
    );
  }

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _mystTeal,
        brightness: Brightness.light,
      ),
      textTheme: base.textTheme.apply(fontFamily: 'CrimsonPro'),
    );
  }
}