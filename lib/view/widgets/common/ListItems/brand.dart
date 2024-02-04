import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class Brand extends StatelessWidget {
  const Brand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: AppColors.secondaryLightCardAppointment,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('كنتاكي',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMedium),
                AutoSizeText(
                  'حي الروضة ي الروضة ي الروضة ي الروضة ي الروضة الرياض',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray,
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  'المجدولين',
                  style: titleMedium.copyWith(fontSize: 12.sp),
                ),
                SizedBox(width: 5),
                Column(
                  children: [Icon(Icons.person), Text('41')],
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CustomButton(
            onTap: () {},
            text: 'تسجيل وصول',
            iconData: Icons.pin_drop_outlined,
          )
        ],
      ),
    );
  }
}
