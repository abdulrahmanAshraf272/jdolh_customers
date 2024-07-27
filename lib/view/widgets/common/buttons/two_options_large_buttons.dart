import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class TwoOptionLargeButtons extends StatelessWidget {
  final String firstOption;
  final String secondOption;
  final void Function() onTapFirst;
  final void Function() onTapSecond;
  const TwoOptionLargeButtons({
    super.key,
    required this.firstOption,
    required this.onTapFirst,
    required this.secondOption,
    required this.onTapSecond,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: onTapFirst,
              color: AppColors.blue,
              child: Container(
                height: 44.h,
                alignment: Alignment.center,
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 7,
                  firstOption,
                  style: titleMedium.copyWith(color: AppColors.white),
                ),
              ),
            )),
        Expanded(
          flex: 1,
          child: MaterialButton(
            onPressed: onTapSecond,
            color: AppColors.green,
            child: Container(
              height: 44.h,
              alignment: Alignment.center,
              child: AutoSizeText(
                maxLines: 1,
                minFontSize: 7,
                secondOption,
                style: titleMedium.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
