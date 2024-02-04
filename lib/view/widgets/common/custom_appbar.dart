import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

AppBar customAppBar({required String title, void Function()? onTapSearch}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.white,
      ),
    ),
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
    ),
    actions: [
      onTapSearch != null
          ? IconButton(
              onPressed: onTapSearch,
              icon: Icon(Icons.search, color: AppColors.white),
            )
          : SizedBox()
    ],
  );
}
