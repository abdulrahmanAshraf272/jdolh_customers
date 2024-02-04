import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class ApptBrandNameAndBywhoAndState extends StatelessWidget {
  const ApptBrandNameAndBywhoAndState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: AppColors.secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/avatar_person.jpg',
              height: 40.h,
              width: 40.h,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('حجز مطعم البيك',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMedium.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.bold)),
                AutoSizeText(
                  'بواسطة عبدالرحمن العنزي',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray.copyWith(color: AppColors.white),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'مؤكد',
              style: titleSmall.copyWith(color: AppColors.secondaryColor),
            ),
          )
        ],
      ),
    );
  }
}
