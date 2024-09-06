import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandScheduledAndRating extends StatelessWidget {
  final int scheduledNo;
  final int ratedBy;
  final double rate;
  final void Function() onTapRates;
  final void Function() onTapScheduled;
  const BrandScheduledAndRating({
    super.key,
    required this.scheduledNo,
    required this.rate,
    required this.ratedBy,
    required this.onTapRates,
    required this.onTapScheduled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapScheduled,
          child: Row(
            children: [
              Text(
                '$scheduledNo مجدولين',
                style:
                    titleSmall3Gray.copyWith(color: AppColors.secondaryColor),
              ),
              Icon(
                Icons.person,
                color: AppColors.secondaryColor,
                size: 20,
              )
            ],
          ),
        ),
        SizedBox(height: 8.sp),
        GestureDetector(
          onTap: onTapRates,
          child: Row(
            children: [
              Text(
                '$ratedBy تقييم',
                style: titleSmall3Gray,
              ),
              const SizedBox(width: 3),
              Rating(
                rating: rate,
                textColor: Colors.white.withOpacity(0.7),
              )
            ],
          ),
        ),
      ],
    );
  }
}
