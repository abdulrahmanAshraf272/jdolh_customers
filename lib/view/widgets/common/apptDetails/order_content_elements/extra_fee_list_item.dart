import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class OrderExtraFeeListItem extends StatelessWidget {
  const OrderExtraFeeListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 40.h,
            color: AppColors.gray350,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'التخفيض',
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
            height: 40.h,
            color: AppColors.gray450,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              '20 ريال',
              style: titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
