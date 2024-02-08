import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandScheduledAndRating extends StatelessWidget {
  const BrandScheduledAndRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '120 مجدولين',
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
              '120 تقييم',
              style: titleSmall3Gray,
            ),
            SizedBox(width: 3),
            Rating(
              rating: 4.5,
              textColor: Colors.white.withOpacity(0.7),
            )
          ],
        ),
      ],
    );
  }
}
