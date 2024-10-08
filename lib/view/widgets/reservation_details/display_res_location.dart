import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/data/models/res_location.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bch_and_reservation_data.dart';

class DisplayResLocation extends StatelessWidget {
  final ResLocation? resLocation;
  final void Function() onTapDisplayLocation;
  const DisplayResLocation(
      {super.key,
      required this.resLocation,
      required this.onTapDisplayLocation});

  @override
  Widget build(BuildContext context) {
    return resLocation == null
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text('العنوان'.tr,
                        style: TextStyle(
                          //fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ))),
                const Divider(),
                Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      onTap: onTapDisplayLocation,
                      text: 'عرض على الخريطة'.tr,
                    )),
                const SizedBox(height: 15),
                DataTextRow(
                  title: 'المدينة'.tr,
                  value: resLocation!.reslocationCity ?? '',
                ),
                const SizedBox(height: 5),
                DataTextRow(
                  title: 'الحي'.tr,
                  value: resLocation!.reslocationHood ?? '',
                ),
                const SizedBox(height: 5),
                DataTextRow(
                  title: 'الشارع'.tr,
                  value: resLocation!.reslocationStreet ?? '',
                ),
                const SizedBox(height: 5),
                DataTextRow(
                  title: 'رقم المنزل'.tr,
                  value: resLocation!.reslocationApartment ?? '',
                ),
                const SizedBox(height: 5),
                DataTextRow(
                  title: 'العنوان الوطني المختصر'.tr,
                  value: resLocation!.reslocationShortAddress ?? '',
                ),
                const SizedBox(height: 5),
                DataTextRow(
                  title: 'معلومات اضافية'.tr,
                  value: resLocation!.reslocationAdditionalInfo ?? '',
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
  }
}
