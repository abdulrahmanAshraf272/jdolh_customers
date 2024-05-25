import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_theme.dart';
import 'package:jdolh_customers/core/services/services.dart';

class LocaleController extends GetxController {
  Locale? language;
  String? lang;

  MyServices myServices = Get.find();

  ThemeData appTheme = themeArabic;

  onTapChangeLanguage(String languageCode) {
    String title;
    String content;
    String confirm;
    String cancel;

    if (lang == 'ar') {
      confirm = "حسناً";
      cancel = 'الغاء';
      content = 'سيتم اغلاق التطبيق لظمان تغيير لغة التطبيق اللغة بالكامل';
      if (languageCode == 'ar') {
        title = 'اللغة العربية';
      } else {
        title = 'اللغة الانجليزية';
      }
    } else {
      confirm = 'confirm';
      cancel = 'cancel';
      content =
          'the app will turned off to make sure the language changed successfuly';
      if (languageCode == 'ar') {
        title = 'Arabic Language';
      } else {
        title = 'English Language';
      }
    }
    Get.defaultDialog(
        title: title,
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        textConfirm: confirm,
        textCancel: cancel,
        onConfirm: () {
          changeLanguage(languageCode);
          SystemNavigator.pop();
        },
        onCancel: () {});
  }

  changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    myServices.sharedPreferences.setString('lang', languageCode);
    //appTheme = languageCode == 'ar' ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();

    lang = myServices.sharedPreferences.getString('lang');
    if (lang == 'ar') {
      language = const Locale('ar');
      appTheme = themeArabic;
    } else if (lang == 'en') {
      language = const Locale('en');
      //appTheme = themeEnglish;
    } else {
      lang = 'ar';
      //language = Locale(Get.deviceLocale!.languageCode);
      language = const Locale('ar');
      //appTheme = themeArabic;
    }
  }
}
