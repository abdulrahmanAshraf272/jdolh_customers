import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

onTapDisplayLocation(Occasion occasion) {
  String occasionLocation = occasion.occasionLocation ?? '';
  String occasionLocationLink = occasion.locationLink ?? '';
  if (occasionLocation != '' && occasionLocationLink != '') {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: AppColors.gray,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'اختر طريقة عرض الموقع',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          GoHomeButton(
              onTap: () {
                openUrlLink(occasionLocationLink);
              },
              text: 'تطبيق Googel Maps',
              width: Get.width - 40,
              height: 38.h),
          const SizedBox(height: 10),
          GoHomeButton(
              onTap: () {
                goToDisplayLocation(occasion);
              },
              text: 'روية الموقع هنا',
              width: Get.width - 40,
              height: 38.h),
        ],
      ),
    ));
  } else if (occasionLocation != '') {
    goToDisplayLocation(occasion);
  } else if (occasionLocationLink != '') {
    //the occasion only have location link
    openUrlLink(occasionLocationLink);
  } else {
    //the occasion doesn't have location nor location link
    Get.rawSnackbar(message: 'لم يتم تحديد مكان المناسبة');
  }
}

goToDisplayLocation(Occasion occasion) {
  double lat = double.parse(occasion.occasionLat!);
  double lng = double.parse(occasion.occasionLong!);
  Get.toNamed(AppRouteName.diplayLocation, arguments: LatLng(lat, lng));
}
