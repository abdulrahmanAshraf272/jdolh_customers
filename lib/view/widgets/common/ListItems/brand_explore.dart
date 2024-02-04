import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class BrandExploreListItem extends StatelessWidget {
  const BrandExploreListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 120.w,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/breakfastDishe24.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          AutoSizeText(
            'ماكدونلدز',
            style: titleMedium,
          )
        ],
      ),
    );
  }
}
