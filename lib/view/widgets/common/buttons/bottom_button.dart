import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class BottomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool colorIsSecondary;
  const BottomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.colorIsSecondary = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color:
          colorIsSecondary ? AppColors.secondaryColor : AppColors.primaryColor,
      child: Container(
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text,
          style: titleMedium.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
