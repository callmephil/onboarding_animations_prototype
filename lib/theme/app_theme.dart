import 'package:app/theme/app_colors.dart';
import 'package:app/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.background,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.surface,
        filled: true,
        floatingLabelStyle: TextStyle(color: AppColors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(15, 15, 14, 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
      ),
      // Global text theme used in our login screen.
      textTheme: TextTheme(
        // Tagline text style.
        bodySmall: GoogleFonts.robotoSerif().copyWith(
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w200,
        ),
        // Forgot password text style.
        labelSmall: GoogleFonts.robotoSerif().copyWith(
          color: AppColors.black,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
        titleLarge: GoogleFonts.roadRage().copyWith(
          color: AppColors.black,
          fontSize: 48,
        ),
        titleMedium: GoogleFonts.roadRage().copyWith(
          color: AppColors.black,
          fontSize: 36,
        ),
        // Login button text style.
        headlineSmall: GoogleFonts.roboto().copyWith(
          color: AppColors.surface,
          fontSize: 26,
        ),
        // "Don't have an account?" text style.
        bodyMedium: GoogleFonts.roboto().copyWith(
          color: AppColors.black,
          fontSize: 14,
        ),
        // Register button text style.
        headlineMedium: GoogleFonts.roboto().copyWith(
          color: AppColors.black,
          fontSize: 26,
        ),
      ),
      // Elevated button theme for the login button.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.black),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: AppSizes.borderRadius4,
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, AppSizes.s48),
          ),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.roboto().copyWith(
              color: AppColors.surface,
              fontSize: 18,
            ),
          ),
          foregroundColor: WidgetStateProperty.all(AppColors.surface),
        ),
      ),
      // Outlined button theme for the register button.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.surface),
          side:
              WidgetStateProperty.all(const BorderSide(color: AppColors.black)),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: AppSizes.borderRadius4,
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, AppSizes.s48),
          ),
        ),
      ),
    );
  }
}
