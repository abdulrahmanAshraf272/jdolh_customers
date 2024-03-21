import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandScheduledAndRating extends StatelessWidget {
  final int scheduledNo;
  final int ratedBy;
  final double rate;
  const BrandScheduledAndRating({
    super.key,
    required this.scheduledNo,
    required this.rate,
    required this.ratedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$scheduledNo مجدولين',
              style: titleSmall3Gray.copyWith(color: AppColors.secondaryColor),
            ),
            Icon(
              Icons.person,
              color: AppColors.secondaryColor,
              size: 20,
            )
          ],
        ),
        Spacer(),
        Row(
          children: [
            Text(
              '$ratedBy تقييم',
              style: titleSmall3Gray,
            ),
            SizedBox(width: 3),
            Rating(
              rating: rate,
              textColor: Colors.white.withOpacity(0.7),
            )
          ],
        ),
      ],
    );
  }
}
