import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class SuspendedReservationListItem extends StatelessWidget {
  final void Function() onTap;
  final Reservation reservation;
  const SuspendedReservationListItem(
      {super.key, required this.onTap, required this.reservation});

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
                      AutoSizeText('${'حجز'.tr} ${reservation.brandName}',
                          maxLines: 1,
                          minFontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          style: titleMedium),
                      AutoSizeText(
                        '${reservation.bchCity} ${reservation.resDate}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleSmallGray,
                      )
                    ],
                  ),
                ),
                Text(
                  reservation.resStatus == 0
                      ? 'بانتظار الموافقة'
                      : reservation.resStatus == 1
                          ? 'تمت الموافقة'
                          : reservation.resStatus == 2
                              ? 'تم الرفض'
                              : '',
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
