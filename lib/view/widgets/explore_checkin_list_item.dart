import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class ExploreCheckinListItem extends StatelessWidget {
  final String name;
  const ExploreCheckinListItem({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: AppColors.gray,
                padding: const EdgeInsets.all(15),
                child: Icon(
                  Icons.location_city,
                  color: Colors.grey,
                  size: 30.w,
                ),
              )),
          const SizedBox(height: 8),
          AutoSizeText(
            name,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
              color: AppColors.textDark,
            ),
          )
        ],
      ),
    );
  }
}
