import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

AppBar customAppBar(
    {required String title, void Function()? onTapSearch, withBack = true}) {
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
    leading: withBack
        ? IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          )
        : const SizedBox(),
    actions: [
      onTapSearch != null
          ? IconButton(
              onPressed: onTapSearch,
              icon: const Icon(Icons.search, color: AppColors.white),
            )
          : const SizedBox()
    ],
  );
}
