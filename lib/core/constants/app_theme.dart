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
            fontWeight: FontWeight.w700, fontSize: 26, color: AppColors.black),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 24, color: AppColors.black),
        bodyLarge: TextStyle(height: 2, color: AppColors.gray)));

ThemeData themeArabic = ThemeData(
    appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor),
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
        displayMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.black),
        bodyLarge: TextStyle(height: 2, color: AppColors.gray)));
