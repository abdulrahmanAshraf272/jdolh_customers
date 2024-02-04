import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

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
