import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

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
              height: 50,
              width: 50,
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

class Rating extends StatelessWidget {
  final double rating;
  const Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$rating',
          style: titleSmallGray.copyWith(
              fontSize: 13.sp, color: AppColors.grayText),
        ),
        const SizedBox(width: 2),
        const Icon(
          Icons.star,
          size: 22,
          color: AppColors.yellowStar,
        ),
      ],
    );
  }
}
