import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class BottomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color buttonColor;
  const BottomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.buttonColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: buttonColor,
      child: Container(
        height: 44.h,
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
