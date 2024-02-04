import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: AppColors.activityCard,
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
                RichText(
                    text: TextSpan(style: titleMedium, children: [
                  TextSpan(
                      text: 'قام ',
                      style: titleMedium.copyWith(fontWeight: FontWeight.w500)),
                  TextSpan(text: 'عبدالرحمن العنزي '),
                  TextSpan(
                      text: 'بتقييم ',
                      style: titleMedium.copyWith(fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'مطعم البيك',
                      style:
                          titleMedium.copyWith(color: AppColors.primaryColor))
                ])),
                AutoSizeText(
                  'الرياض 2:00 2022/10/23',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray,
                )
              ],
            ),
          ),
          Rating(rating: 5.0)
          //Icon(Icons.pin_drop_outlined)
        ],
      ),
    );
  }
}
