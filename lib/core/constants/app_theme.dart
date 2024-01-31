import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

ThemeData themeEnglish = ThemeData(
    appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor),
    //colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
    primarySwatch: Colors.orange,
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.grey),
        displayMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.grey),
        bodyLarge: TextStyle(height: 2, color: AppColors.grey)));

ThemeData themeArabic = ThemeData(
    appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor),
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.grey),
        displayMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.grey),
        bodyLarge: TextStyle(height: 2, color: AppColors.grey)));
