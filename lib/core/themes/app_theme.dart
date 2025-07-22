import 'package:flutter/material.dart';
import 'app_colores.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.bink,
    scaffoldBackgroundColor: AppColors.white,
    // Add more theme properties
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.bink,
    scaffoldBackgroundColor: AppColors.darkBackground,
    // Add more theme properties
  );
}