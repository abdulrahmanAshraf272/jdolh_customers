import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class OrderContentTitle extends StatelessWidget {
  const OrderContentTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            height: 50.h,
            color: AppColors.gray450,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('الصنف', style: titleSmall),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 50.h,
            color: AppColors.gray350,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'العدد',
              style: titleSmall,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            height: 50.h,
            color: AppColors.gray450,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              'المبلغ',
              style: titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
