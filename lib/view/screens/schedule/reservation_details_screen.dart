import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/schedule/reservation_details_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bill_datails.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_product.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_service.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bch_and_reservation_data.dart';
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
                    const BchDataHeader(),
                    const BchLocation(),
                    const ContactNumber(),
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
                    const BillDetails(),
                    const SizedBox(height: 20),
                    if (controller.suspended == false)
                      TextButton(
                          onPressed: () {
                            controller.onTapCancelReservation();
                          },
                          child: const Text(
                            'الغاء الحجز',
                            style: TextStyle(color: AppColors.redButton),
                          )),
                    const SizedBox(height: 80)
                  ],
                ),
              ),
            ));
  }
}

class ResCartData extends StatelessWidget {
  const ResCartData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationDetailsController());
    return controller.isService
        ? const Column(
            children: [
              CustomTitle(title: 'الخدمات'),
              CartService(),
            ],
          )
        : const Column(
            children: [
              CustomTitle(title: 'تفاصيل الطلب'),
              SizedBox(height: 15),
              OrderContentTitle(),
              CartProduct(),
            ],
          );
  }
}
