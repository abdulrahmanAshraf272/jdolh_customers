import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class OrderTotalPriceWithFees extends StatelessWidget {
  const OrderTotalPriceWithFees({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 50.h,
            color: AppColors.secondaryLightCardAppointment,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'المجموع شامل الضريبة',
                  textAlign: TextAlign.start,
                  style: titleSmall,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 50.h,
            color: AppColors.secondaryColor,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              '20 ريال',
              style: titleMedium.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
