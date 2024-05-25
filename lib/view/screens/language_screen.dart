import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/localization/change_locale.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class LanguageScreen extends GetView<LocaleController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'اللغة'.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LanguageButton(
              title: 'العربية'.tr,
              onTap: () => controller.onTapChangeLanguage('ar'),
              selected: controller.lang == 'ar' ? true : false),
          LanguageButton(
              title: 'الإنجليزية'.tr,
              onTap: () => controller.onTapChangeLanguage('en'),
              selected: controller.lang == 'en' ? true : false),
        ],
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final bool selected;
  const LanguageButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: selected ? null : onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  Expanded(child: Text(title)),
                  if (selected)
                    const Icon(
                      Icons.check,
                      color: Colors.blue,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
