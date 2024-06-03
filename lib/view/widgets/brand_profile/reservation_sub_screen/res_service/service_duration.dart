import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/cart_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class ServiceDuration extends StatelessWidget {
  const ServiceDuration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: GetBuilder<CartController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مدة الخدمة'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 48,
                //width: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('${controller.totalServiceDuration} ${'دقيقة'.tr}'),
              )
            ],
          ),
        ));
  }
}
