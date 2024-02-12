import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class AppointmentListItem extends StatelessWidget {
  final void Function() onTap;
  const AppointmentListItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryLightCardAppointment,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/avatar_person.jpg',
                    height: 40.h,
                    width: 40.h,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText('حجز البيك',
                          maxLines: 1,
                          minFontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          style: titleMedium),
                      AutoSizeText(
                        'الرياض 2:00 2022/10/23',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleSmallGray,
                      )
                    ],
                  ),
                ),
                Text(
                  'اشخاص 5',
                  style: titleMedium.copyWith(fontSize: 12.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentListItemNotApproved extends StatelessWidget {
  const AppointmentListItemNotApproved({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: AppColors.redLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/avatar_person.jpg',
              height: 40.h,
              width: 40.h,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'حجز البيك',
                  maxLines: 1,
                  minFontSize: 15,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.textDark),
                ),
                AutoSizeText(
                  'الرياض 2:00 2022/10/23',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray,
                ),
                AutoSizeText(
                  'مرسلة بواسطة عبدالرحمن العنزي',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray.copyWith(color: AppColors.redText),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
