import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class VyroTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AppConstants.background,
        colorScheme: const ColorScheme.dark(
          primary: AppConstants.accent,
          secondary: AppConstants.accentBlue,
          surface: AppConstants.panel,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.background,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
}
