import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

// ThemeData themeEnglish = ThemeData(
//   scaffoldBackgroundColor: Colors.white,
//   appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       backgroundColor: AppColors.primaryColor),
//   //colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
//   primarySwatch: Colors.orange,
//   fontFamily: 'Cairo',
// );

ThemeData themeArabic = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor),
  fontFamily: 'Cairo',
);
