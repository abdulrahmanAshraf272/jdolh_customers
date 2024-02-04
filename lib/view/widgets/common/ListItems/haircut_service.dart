import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class HairCutServiceListItem extends StatelessWidget {
  const HairCutServiceListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/avatar_person.jpg',
              fit: BoxFit.cover,
              height: 40.h,
              width: 70.h,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('حلاقة دقن',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMedium),
                Text(
                  '20 دقيقة',
                  style: titleSmallGray,
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Text(
                '60 ريال',
                style: titleSmall,
              )),
          CustomButton(
            onTap: () {},
            text: 'اضف حجز',
            buttonColor: AppColors.green,
          )
        ],
      ),
    );
  }
}
