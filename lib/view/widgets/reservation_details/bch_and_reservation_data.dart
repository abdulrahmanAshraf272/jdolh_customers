import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class BchDataHeader extends StatelessWidget {
  final Reservation reservation;
  const BchDataHeader({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: reservation.brandLogo != ''
                    ? FadeInImage.assetNetwork(
                        width: 40.w,
                        height: 40.w,
                        placeholder: 'assets/images/loading2.gif',
                        image: '${ApiLinks.logoImage}/${reservation.brandLogo}',
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
                    AutoSizeText('${'حجز'.tr} ${reservation.brandName ?? ''}',
                        maxLines: 1,
                        minFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.white,
                        )),
                    AutoSizeText(
                      '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleSmallGray,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BchLocation extends StatelessWidget {
  final Reservation reservation;
  final void Function() onTapDisplayLocation;
  const BchLocation(
      {super.key,
      required this.reservation,
      required this.onTapDisplayLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(reservation.bchLocation ?? '', style: titleSmall),
              ),
              Container(
                color: AppColors.gray,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapDisplayLocation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text('عرض على الخريطة'.tr, style: titleSmall2),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade300)
        ],
      ),
    );
  }
}

class ReservationData extends StatelessWidget {
  final String date;
  final String time;
  final String resOption;
  final String duration;
  const ReservationData({
    super.key,
    required this.resOption,
    required this.duration,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: Text('بيانات الحجز'.tr,
                  style: TextStyle(
                    //fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: AppColors.black,
                  ))),
          const Divider(),
          const SizedBox(height: 15),
          DataTextRow(
            title: 'التاريخ'.tr,
            value: date,
          ),
          Row(
            children: [
              Text(
                'الوقت: '.tr,
                style: const TextStyle(fontSize: 16),
              ),
              AutoSizeText(
                maxLines: 1,
                textDirection: TextDirection.ltr,
                time,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 5),
          DataTextRow(
            title: 'التفضيل'.tr,
            value: resOption,
          ),
          const SizedBox(height: 5),
          DataTextRow(
            title: 'مدة الحجز'.tr,
            value: duration,
            endText: 'دقيقة'.tr,
          ),
        ],
      ),
    );
  }
}

// class BchData extends StatelessWidget {
//   final String customerName;
//   final String phoneNumber;
//   final String customerEmail;
//   const BchData({
//     super.key,
//     required this.customerName,
//     required this.phoneNumber,
//     required this.customerEmail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       decoration: BoxDecoration(
//         color: AppColors.gray,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Align(
//               alignment: Alignment.center,
//               child: Text('بيانات الفرع',
//                   style: TextStyle(
//                     //fontWeight: FontWeight.w700,
//                     fontSize: 16.sp,
//                     color: AppColors.black,
//                   ))),
//           const Divider(),
//           const SizedBox(height: 15),
//           const SizedBox(height: 5),
//           ContactNumber(phoneNumber: phoneNumber),
//           const SizedBox(height: 5),
//         ],
//       ),
//     );
//   }
// }

class ContactNumber extends StatelessWidget {
  final Reservation reservation;
  final void Function() onTapCallBch;
  const ContactNumber(
      {super.key, required this.reservation, required this.onTapCallBch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'رقم التواصل: '.tr,
            style: const TextStyle(fontSize: 16),
          ),
          Expanded(
            child: AutoSizeText(
              maxLines: 1,
              textAlign: TextAlign.right,
              textDirection: TextDirection.ltr,
              reservation.bchContactNumber ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
              onPressed: onTapCallBch,
              icon: const Icon(
                Icons.phone,
                color: AppColors.secondaryColor,
              ))
        ],
      ),
    );
  }
}

class DataTextRow extends StatelessWidget {
  final String title;
  final String value;
  final String endText;
  const DataTextRow(
      {super.key, required this.title, required this.value, this.endText = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(fontSize: 16),
        ),
        Expanded(
          child: AutoSizeText(
            maxLines: 1,
            value != '' ? '$value $endText' : '-',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
