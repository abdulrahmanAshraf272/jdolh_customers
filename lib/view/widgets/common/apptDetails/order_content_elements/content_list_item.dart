import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class OrderContentListItem extends StatelessWidget {
  const OrderContentListItem({
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
            color: AppColors.gray400,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/avatar_person.jpg',
                    height: 32.h,
                    width: 32.h,
                  ),
                ),
                const SizedBox(width: 12),
                AutoSizeText('ورق عنب',
                    maxLines: 2,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleSmall),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 50.h,
            color: AppColors.gray300,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              '3',
              style: titleMedium,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            height: 50.h,
            color: AppColors.gray400,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              '20 ريال',
              style: titleSmall.copyWith(fontSize: (13.5).sp),
            ),
          ),
        ),
      ],
    );
  }
}
