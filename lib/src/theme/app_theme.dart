import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      onSurface: AppColors.black,
      primary: AppColors.primaryDark,
      surface: AppColors.surfaceWhite

    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(size: 20, color: Colors.black),
    ),
    primaryColor: AppColors.buttonPrimary,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
    ),
    textTheme: TextTheme(
      bodyMedium: _textStyle(fontSize: 14, fontWeight: FontWeight.w400),
      titleLarge: _textStyle(fontSize: 24, fontWeight: FontWeight.w700),
      titleMedium: _textStyle(fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: _textStyle(fontSize: 14, fontWeight: FontWeight.w500),
      headlineMedium: _textStyle(fontSize: 18, fontWeight: FontWeight.w700),
      headlineLarge: _textStyle(fontSize: 20, fontWeight: FontWeight.w700),
      headlineSmall: _textStyle(fontSize: 16),
      bodyLarge: _textStyle(fontSize: 16),
      bodySmall: _textStyle(fontSize: 12),
    ),
    fontFamily: 'Manrope',
  );
  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryLight,
      onSurface: AppColors.white,
      surface: AppColors.surfaceDark,
    ),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(size: 20, color: Colors.black),
    ),
    primaryColor: AppColors.buttonPrimary,
    textTheme: TextTheme(
      bodyMedium: _textStyle(fontSize: 14, fontWeight: FontWeight.w400),
      titleLarge: _textStyle(fontSize: 24, fontWeight: FontWeight.w500),
      titleMedium: _textStyle(fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: _textStyle(fontSize: 14, fontWeight: FontWeight.w500),
      headlineMedium: _textStyle(fontSize: 18, fontWeight: FontWeight.w500),
      headlineLarge: _textStyle(fontSize: 20, fontWeight: FontWeight.w700),
      headlineSmall: _textStyle(fontSize: 16),
      bodyLarge: _textStyle(fontSize: 16,fontWeight: FontWeight.w400),
      bodySmall: _textStyle(fontSize: 12),
    ),
    fontFamily: 'Manrope',
  );

  static TextStyle _textStyle({
    required double fontSize,
    double? letterSpacing,
    Color? color,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: fontSize,
    color: color,
    fontFamily: 'Manrope',
    letterSpacing: letterSpacing ?? -.41,
    fontWeight: fontWeight ?? FontWeight.w500,
  );
}
