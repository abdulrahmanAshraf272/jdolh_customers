import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class OrderContentCreationListItem extends StatelessWidget {
  const OrderContentCreationListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText('ورق عنب',
                        maxLines: 2,
                        minFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        style: titleSmall),
                    Text('35 ريال',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
              height: 50.h,
              color: AppColors.gray300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onTap: () {}, text: '+'),
                  Text(
                    '1',
                    style: titleMedium,
                  ),
                  CustomButton(onTap: () {}, text: '+'),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'ازالة',
                        style: titleSmall.copyWith(color: AppColors.redButton),
                      )),
                ],
              )),
        ),
      ],
    );
  }
}
