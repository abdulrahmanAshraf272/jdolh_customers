import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class GoHomeButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double width;
  final double height;
  const GoHomeButton({
    super.key,
    required this.onTap,
    this.text = 'الرجوع للرئيسية',
    this.buttonColor = AppColors.secondaryColor,
    this.textColor = AppColors.white,
    this.width = 120,
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: MaterialButton(
        onPressed: () {},
        color: buttonColor,
        child: Container(
          height: height.h,
          width: width.w,
          alignment: Alignment.center,
          child: Text(
            text,
            style: titleMedium.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
