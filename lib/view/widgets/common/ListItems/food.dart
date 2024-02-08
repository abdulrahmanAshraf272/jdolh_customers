import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width - 40,
        height: 110.h,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/breakfastDishe24.jpg',
                fit: BoxFit.cover,
              ),
            )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent
                        ])),
              ),
            ),
            Positioned(
                bottom: 15,
                child: Container(
                  width: Get.width - 40,
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          'بان كيك',
                          style: titleMedium.copyWith(
                              color: AppColors.white, fontSize: 16.sp),
                          maxLines: 2,
                        ),
                      ),
                      Text('25 ريال',
                          style: titleMedium.copyWith(
                              color: AppColors.secondaryColor, fontSize: 16.sp))
                    ],
                  ),
                ))
          ],
        ));
  }
}
