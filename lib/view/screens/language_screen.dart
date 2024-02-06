import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/localization/change_locale.dart';
import 'package:jdolh_customers/core/localization/words/language.dart';
import 'package:jdolh_customers/view/widgets/language/custom_button_lang.dart';

class LanguageScreen extends GetView<LocaleController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(WordsLanguage.wordKey1.tr, style: headline4),
            const SizedBox(height: 20),
            CustomButtonLang(
                textButton: WordsLanguage.wordKey2.tr,
                onPressed: () {
                  controller.changeLanguage('ar');
                  Get.toNamed(AppRouteName.home);
                }),
            CustomButtonLang(
                textButton: WordsLanguage.wordKey3.tr,
                onPressed: () {
                  controller.changeLanguage('en');
                  Get.toNamed(AppRouteName.home);
                })
          ],
        ),
      ),
    );
  }
}
