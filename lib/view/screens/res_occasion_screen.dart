import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ResOccasionScreen extends StatelessWidget {
  const ResOccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'جدولة'.tr, withBack: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BigCard(
                title: 'الحجوزات'.tr,
                image: 'assets/images/reservation.png',
                onTap: () {
                  Get.toNamed(AppRouteName.schedule);
                }),
            BigCard(
                title: 'المناسبات'.tr,
                image: 'assets/images/party2.png',
                onTap: () {
                  Get.toNamed(AppRouteName.occasions);
                }),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String title;
  const BigCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * 0.3,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.gray,
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                  ),
                  Image.asset(
                    image,
                    height: Get.height * 0.2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
