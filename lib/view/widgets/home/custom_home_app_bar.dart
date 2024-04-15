import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

AppBar customHomeAppBar(
    {required void Function() onTapSearch,
    required void Function() onTapNotification}) {
  return AppBar(
    title: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTapSearch,
            child: Container(
              height: 30.h,
              //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.white,
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 5),
                  Expanded(
                    child: AutoSizeText('البحث باسم المستخدم او اسم التاجر',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                          color: Colors.grey,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: onTapNotification,
            icon: const Icon(
              Icons.notifications_active,
              color: AppColors.white,
              size: 28,
            ))
      ],
    ),
  );
}
