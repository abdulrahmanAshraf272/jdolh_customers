import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/schedule/reservation_with_invitors_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/screens/schedule/reservation_confirm_wait_screen.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bch_and_reservation_data.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bill_datails.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_product.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/reservation_date.dart';

class ReservationWithInvitorsDetailsScreen extends StatelessWidget {
  const ReservationWithInvitorsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationWithInvitorsDetailsController());

    return Scaffold(
      appBar: customAppBar(
        title: '${'تفاصيل الحجز رقم:'.tr} #${controller.reservation.resId}',
      ),
      bottomNavigationBar: controller.reservation.creator == 0 &&
              controller.reservation.invitorStatus == 0
          ? ConfirmRefuseButtons(
              onTapConfirm: () => controller.onTapAccept(context),
              onTapRefuse: () => controller.onTapReject(context))
          : null,
      body: GetBuilder<ReservationWithInvitorsDetailsController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              BchDataHeader(reservation: controller.reservation),
              BchLocation(
                reservation: controller.reservation,
                onTapDisplayLocation: () => controller.onTapDisplayLocation(),
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text('المقاعد الاضافية: '.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                          color: AppColors.textDark,
                        )),
                    Text(
                      '${controller.reservation.extraSeats}',
                      style: titleMedium,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LargeToggleButtons(
                    optionOne:
                        '${'المدعوين'.tr} (${controller.resInvitors.length})',
                    optionTwo: 'تفاصيل الطلب'.tr,
                    onTapOne: () => controller.changeSubscreen(true),
                    onTapTwo: () => controller.changeSubscreen(false),
                  ),
                ),
              ),
              if (controller.reservation.resPaymentType == 'R')
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('قيمة الفاتورة تدفع عند الوصول'.tr),
                ),
              controller.displayResInvitorsPart
                  ? const ResInvitorsStatus()
                  : const OrderDetails(),
              const SizedBox(height: 70),
              controller.reservation.creator == 1
                  ? TextButton(
                      onPressed: () =>
                          controller.onTapCancelReservation(context),
                      child: Text(
                        'الغاء الحجز'.tr,
                        style: const TextStyle(color: Colors.red),
                      ))
                  : controller.reservation.invitorStatus == 1
                      ? TextButton(
                          onPressed: () =>
                              controller.onTapLeaveReservation(context),
                          child: Text(
                            'مغادرة الحجز'.tr,
                            style: const TextStyle(color: Colors.red),
                          ))
                      : const SizedBox(height: 0),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class ResInvitorsStatus extends StatelessWidget {
  const ResInvitorsStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationWithInvitorsDetailsController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusGetInvitors,
            widget: Column(
              children: [
                const SizedBox(height: 15),
                CustomButton(
                    onTap: () => controller.getInvitors(), text: 'تحديث'),
                const SizedBox(height: 10),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    itemCount: controller.resInvitors.length,
                    itemBuilder: (context, index) => InvitorStatusListItem(
                        resinvitor: controller.resInvitors[index])),
              ],
            )));
  }
}

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationWithInvitorsDetailsController>(
        builder: (controller) => Column(
              children: [
                const SizedBox(height: 20),
                CustomTitle(title: 'تفاصيل الطلب'.tr),
                const SizedBox(height: 15),
                const OrderContentTitle(),
                CartProduct(
                  statusRequest: controller.statusResCart,
                  carts: controller.carts,
                ),
                const SizedBox(height: 20),
                BillDetails(reservation: controller.reservation),
                const SizedBox(height: 20),
              ],
            ));
  }
}
