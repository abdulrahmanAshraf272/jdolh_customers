import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';

class SearchButton extends StatelessWidget {
  final void Function() onTap;
  const SearchButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: BottomButton(
          onTap: onTap,
          text: 'بحث'.tr,
          buttonColor: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
