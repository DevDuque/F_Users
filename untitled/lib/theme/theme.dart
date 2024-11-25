import 'package:flutter/material.dart';
import './colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      // Definindo o tema de cores
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,

      // Definindo o tema de texto
      textTheme: const TextTheme(

        titleLarge: TextStyle(
          fontSize: 24,
          color: AppColors.primaryColor,
        ),

        titleMedium: TextStyle(
            fontSize: 16,
            color: AppColors.primaryColor,
          ),

        labelMedium: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
        ),

        displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.backgroundColor,
        )

      ),

      appBarTheme: const AppBarTheme(

        titleTextStyle: TextStyle(
          fontSize: 24,
          color: AppColors.textColor,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.textColor.withOpacity(0.2),

        hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)),

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      )
    );
  }
}
