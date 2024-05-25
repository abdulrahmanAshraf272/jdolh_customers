import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double topPadding;
  final double bottomPadding;
  final double rightPdding;
  final double leftPadding;
  final TextStyle? customTextStyle;
  const CustomTitle(
      {super.key,
      required this.title,
      this.onTap,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.rightPdding = 20,
      this.leftPadding = 20,
      this.customTextStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: leftPadding,
          right: rightPdding,
          top: topPadding,
          bottom: bottomPadding),
      child: Row(
        children: [
          Expanded(
            child: customTextStyle == null
                ? AutoSizeText(
                    title,
                    maxLines: 1,
                    style: titleLarge,
                  )
                : AutoSizeText(
                    title,
                    maxLines: 1,
                    style: customTextStyle,
                  ),
          ),
          onTap != null
              ? TextButton(
                  onPressed: onTap,
                  child: Text(
                    'عرض الكل'.tr,
                    style: titleSmall.copyWith(color: AppColors.secondaryColor),
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}

class CustomSmallTitle extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double topPadding;
  final double bottomPadding;
  final double rightPdding;
  final double leftPadding;
  final TextStyle? customTextStyle;
  const CustomSmallTitle(
      {super.key,
      required this.title,
      this.onTap,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.rightPdding = 20,
      this.leftPadding = 20,
      this.customTextStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: leftPadding,
          right: rightPdding,
          top: topPadding,
          bottom: bottomPadding),
      child: Row(
        children: [
          Expanded(
            child: customTextStyle == null
                ? AutoSizeText(
                    title,
                    maxLines: 1,
                    style: titleMedium,
                  )
                : AutoSizeText(
                    title,
                    maxLines: 1,
                    style: customTextStyle,
                  ),
          ),
          onTap != null
              ? TextButton(
                  onPressed: onTap,
                  child: Text(
                    'عرض الكل',
                    style: titleSmall.copyWith(color: AppColors.secondaryColor),
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}

class CustomSmallBoldTitle extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double topPadding;
  final double bottomPadding;
  final double rightPdding;
  final double leftPadding;
  final TextStyle? customTextStyle;
  const CustomSmallBoldTitle(
      {super.key,
      required this.title,
      this.onTap,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.rightPdding = 20,
      this.leftPadding = 20,
      this.customTextStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: leftPadding,
          right: rightPdding,
          top: topPadding,
          bottom: bottomPadding),
      child: Row(
        children: [
          Expanded(
            child: customTextStyle == null
                ? AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: AppColors.textDark,
                    ),
                  )
                : AutoSizeText(
                    title,
                    maxLines: 1,
                    style: customTextStyle,
                  ),
          ),
          onTap != null
              ? TextButton(
                  onPressed: onTap,
                  child: Text(
                    'عرض الكل',
                    style: titleSmall.copyWith(color: AppColors.secondaryColor),
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}
