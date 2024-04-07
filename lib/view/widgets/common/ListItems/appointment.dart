import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class AppointmentListItem extends StatelessWidget {
  final void Function() onTap;
  final String brandName;
  final String? brandLogo;
  final String bchCity;
  final String dateTime;
  const AppointmentListItem({
    super.key,
    required this.onTap,
    required this.brandName,
    required this.brandLogo,
    required this.bchCity,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.secondaryLightCardAppointment,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: brandLogo != null
                          ? FadeInImage.assetNetwork(
                              width: 40.w,
                              height: 40.w,
                              placeholder: 'assets/images/loading2.gif',
                              image: brandLogo!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/noImageAvailable.jpg',
                              fit: BoxFit.cover,
                              width: 40.w,
                              height: 40.w,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText('حجز $brandName',
                              maxLines: 1,
                              minFontSize: 15,
                              overflow: TextOverflow.ellipsis,
                              style: titleMedium),
                          AutoSizeText(
                            '$bchCity $dateTime',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titleSmallGray,
                          )
                        ],
                      ),
                    ),
                    // Text(
                    //   'اشخاص 5',
                    //   style: titleMedium.copyWith(fontSize: 12.sp),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          color: AppColors.secondaryLightCardAppointment,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 2,
            width: Get.width,
            color: AppColors.secondaryColor600,
          ),
        )
      ],
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
