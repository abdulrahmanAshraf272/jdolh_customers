import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class ReservationDate extends StatelessWidget {
  final String date;
  final String time;
  const ReservationDate({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 42.h,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor300,
                borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                const Icon(
                  Icons.date_range,
                  color: AppColors.secondaryColor,
                  size: 23,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: AutoSizeText(date,
                      maxLines: 1, minFontSize: 3, style: titleSmall),
                ),
              ],
            ),
          )),
          const SizedBox(width: 8),
          Expanded(
              child: Container(
            height: 42.h,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor300,
                borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: AppColors.secondaryColor,
                  size: 23,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: AutoSizeText(time,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                      minFontSize: 3,
                      style: titleSmall),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
