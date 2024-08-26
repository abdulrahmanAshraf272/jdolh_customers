import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/convert_time_to_am_pm.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

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
    return Container(
      color: AppColors.secondaryLightCardAppointment,
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      AutoSizeText('${'حجز'.tr} $brandName',
                          maxLines: 1,
                          minFontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          style: titleMedium),
                      AutoSizeText(
                        dateTime,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleSmallGray,
                      ),
                      AutoSizeText(
                        bchCity,
                        textDirection: TextDirection.ltr,
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
    );
  }
}

class AppointmentListItemNotApproved extends StatelessWidget {
  final Reservation reservation;
  final void Function() onTap;
  const AppointmentListItemNotApproved(
      {super.key, required this.reservation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.redLight,
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                  child: reservation.brandLogo != null
                      ? FadeInImage.assetNetwork(
                          width: 40.w,
                          height: 40.w,
                          placeholder: 'assets/images/loading2.gif',
                          image:
                              '${ApiLinks.logoImage}/${reservation.brandLogo}',
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
                      AutoSizeText(
                        '${'حجز'.tr} ${reservation.brandName}',
                        maxLines: 1,
                        minFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.textDark),
                      ),
                      AutoSizeText(
                        '${reservation.resDate} ${timeInAmPm(reservation.resTime!)}',
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleSmallGray,
                      ),
                      AutoSizeText(
                        '${'مرسلة بواسطة'.tr} ${reservation.username}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            titleSmallGray.copyWith(color: AppColors.redText),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
