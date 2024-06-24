import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bill_datails.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bch_and_reservation_data.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/res_cart_data.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/reservation_date.dart';

class ReservationDetailsScreen extends StatelessWidget {
  const ReservationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReservationDetailsController());
    return GetBuilder<ReservationDetailsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                title:
                    '${'تفاصيل الحجز رقم:'.tr} #${controller.reservation.resId}',
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    BchDataHeader(reservation: controller.reservation),
                    BchLocation(
                      reservation: controller.reservation,
                      onTapDisplayLocation: () =>
                          controller.onTapDisplayLocation(),
                    ),
                    ContactNumber(
                        reservation: controller.reservation,
                        onTapCallBch: () => controller.callBch()),
                    const SizedBox(height: 5),
                    ReservationDate(
                        date: controller.reservation.resDate ?? '',
                        time: controller.resTime),
                    const SizedBox(height: 5),
                    ReservationData(
                      date: '${controller.reservation.resDate}',
                      time: controller.resTime,
                      resOption: controller.reservation.resResOption ?? '',
                      duration: controller.reservation.resDuration.toString(),
                    ),
                    const SizedBox(height: 20),
                    const ResCartData(),
                    const SizedBox(height: 20),
                    BillDetails(reservation: controller.reservation),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          controller.onTapCancelReservation();
                        },
                        child: Text(
                          'الغاء الحجز'.tr,
                          style: const TextStyle(color: AppColors.redButton),
                        )),
                    const SizedBox(height: 80)
                  ],
                ),
              ),
            ));
  }
}
