import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_general.dart';

import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class DayWorkTimeDisplayer extends StatelessWidget {
  final String day;
  final String timeFromP1;
  final String timeToP1;
  final String timeFromP2;
  final String timeToP2;
  final bool checkboxInit;
  const DayWorkTimeDisplayer({
    super.key,
    required this.day,
    required this.timeFromP1,
    required this.timeToP1,
    required this.timeFromP2,
    required this.timeToP2,
    this.checkboxInit = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isThereP2 = timeFromP2 != '' || timeToP2 != '' ? true : false;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            SizedBox(width: 85.w),
            Spacer(),
            Text(
              day,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: AppColors.textDark,
              ),
            ),
            const Spacer(),
            CustomToggleGeneral(
              onTap: () {},
              title: 'أجازة'.tr,
              initialValue: checkboxInit,
              isClickable: false,
            ),
            const SizedBox(width: 20),
          ],
        ),
        const Divider(
          endIndent: 30,
          indent: 30,
        ),
        isThereP2
            ? CustomSmallTitle(title: 'الفترة الاولى'.tr, rightPdding: 30)
            : const SizedBox(),
        FromToTimeDisplayer(timeFrom: timeFromP1, timeTo: timeToP1),
        const SizedBox(height: 20),
        isThereP2
            ? Column(
                children: [
                  CustomSmallTitle(title: 'الفترة الثانية'.tr, rightPdding: 30),
                  FromToTimeDisplayer(timeFrom: timeFromP2, timeTo: timeToP2),
                  const SizedBox(height: 20)
                ],
              )
            : const SizedBox()
      ],
    );
  }
}

class FromToTimeDisplayer extends StatelessWidget {
  final String timeFrom;
  final String timeTo;
  const FromToTimeDisplayer({
    super.key,
    required this.timeFrom,
    required this.timeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 30),
        Text(
          'من'.tr,
          maxLines: 1,
          style: titleMedium,
        ),
        SmallTimeDisplayer(timeText: timeFrom),
        const SizedBox(width: 20),
        Text(
          'الى'.tr,
          maxLines: 1,
          style: titleMedium,
        ),
        SmallTimeDisplayer(timeText: timeTo),
      ],
    );
  }
}

class SmallTimeDisplayer extends StatelessWidget {
  final String timeText;
  const SmallTimeDisplayer({
    super.key,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 75.w,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        //border: Border.all(color: Colors.black26),
        color: AppColors.gray,
      ),
      child: AutoSizeText(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        timeText,
        maxLines: 1,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
