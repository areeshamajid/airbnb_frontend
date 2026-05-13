// lib/theme/app_theme.dart
//
// Single source of truth for all colors and theme data.
// No more Color(0xFFFF5A5F) scattered around the app.
// To rebrand the app, update colors here only.

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // prevent instantiation

  // Brand
  static const Color primary     = Color(0xFFFF5A5F);
  static const Color background  = Color(0xFFF7F7F7);

  // Text
  static const Color textPrimary = Colors.black;
  static const Color textGrey    = Colors.grey;
  static const Color textWhite   = Colors.white;
  static const Color textRed     = Colors.red;

  // Icons
  static const Color iconGrey    = Colors.grey;
  static const Color iconAmber   = Colors.amber;
}

class AppTheme {
  AppTheme._(); // prevent instantiation

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,

        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textWhite,
          ),
        ),

        // ElevatedButton theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),

        // Switch theme
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.primary
                : null,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.primary.withOpacity(0.5)
                : null,
          ),
        ),

        // Card theme
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        scaffoldBackgroundColor: AppColors.background,
      );
}