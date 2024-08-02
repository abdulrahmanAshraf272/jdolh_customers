import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
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
                    PaymentTypeText(reservation: controller.reservation),
                    const ResCartData(),
                    const SizedBox(height: 20),
                    BillDetails(reservation: controller.reservation),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          controller.onTapCancelReservation(context);
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

class PaymentTypeText extends StatelessWidget {
  final Reservation reservation;
  const PaymentTypeText({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                style: const TextStyle(
                    fontFamily: 'Cairo', color: AppColors.black),
                children: [
                  TextSpan(
                      text:
                          'رسوم الحجز: ${reservation.resResCost! + reservation.resResTax!} ريال  '),
                  reservation.resResPayed == 1
                      ? const TextSpan(
                          text: 'مدفوع', style: TextStyle(color: Colors.green))
                      : const TextSpan(
                          text: 'غير مدفوع',
                          style: TextStyle(color: Colors.red))
                ]),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
                style: const TextStyle(
                    fontFamily: 'Cairo', color: AppColors.black),
                children: [
                  TextSpan(
                      text:
                          'قيمة الفاتورة: ${reservation.resBillCost! + reservation.resBillTax!} ريال  '),
                  reservation.resBillPayed == 1
                      ? const TextSpan(
                          text: 'مدفوع', style: TextStyle(color: Colors.green))
                      : const TextSpan(
                          text: 'غير مدفوع',
                          style: TextStyle(color: Colors.red))
                ]),
          ),
          const SizedBox(height: 15),
          Text(
            'شامل ضريبة القيمة المضافة',
            style: titleSmall,
          ),
        ],
      ),
    );
  }
}
