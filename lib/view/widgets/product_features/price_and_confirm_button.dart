import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class PriceAndConfirmReservationButton extends StatelessWidget {
  final String price;
  final Function() onTap;
  const PriceAndConfirmReservationButton(
      {super.key, required this.onTap, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              height: 44.h,
              alignment: Alignment.center,
              color: AppColors.secondaryColor700,
              child: Text(
                '$price ريال',
                style: titleMedium.copyWith(color: AppColors.white),
              ),
            )),
        Expanded(
          flex: 4,
          child: MaterialButton(
            onPressed: onTap,
            color: AppColors.primaryColor,
            child: Container(
              height: 44.h,
              alignment: Alignment.center,
              child: Text(
                'إضافة الحجز',
                style: titleMedium.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
