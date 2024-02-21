import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_theme.dart';
import 'package:jdolh_customers/core/services/services.dart';

class LocaleController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData appTheme = themeArabic;

  changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    myServices.sharedPreferences.setString('lang', languageCode);
    appTheme = languageCode == 'ar' ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();

    String? sharedPrefs = myServices.sharedPreferences.getString('lang');
    if (sharedPrefs == 'ar') {
      language = const Locale('ar');
      appTheme = themeArabic;
    } else if (sharedPrefs == 'en') {
      language = const Locale('en');
      appTheme = themeEnglish;
    } else {
      //language = Locale(Get.deviceLocale!.languageCode);
      language = const Locale('ar');
      appTheme = themeArabic;
    }
  }
}
