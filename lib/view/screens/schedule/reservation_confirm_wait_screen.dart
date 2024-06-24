import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/schedule/reservation_confirm_wait_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bch_and_reservation_data.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/bill_datails.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/cart_product.dart';
import 'package:jdolh_customers/view/widgets/reservation_details/reservation_date.dart';

class ReservationConfirmWaitScreen extends StatelessWidget {
  const ReservationConfirmWaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationConfirmWaitController());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${'تفاصيل الحجز رقم:'.tr} #${controller.reservation.resId}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () => controller.goBackAlert(),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          )),
      floatingActionButton: GoHomeButton(
          onTap: () => controller.onTapConfirmReservation(),
          text: 'تأكيد الحجز'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<ReservationConfirmWaitController>(
          builder: (controller) => SingleChildScrollView(
                  child: Column(
                children: [
                  BchDataHeader(reservation: controller.reservation),
                  const HoldReservationTimer(),
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text('المقاعد الاضافية: ',
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
                            'المدعوين (${controller.resInvitors.length})',
                        optionTwo: 'تفاصيل الطلب',
                        onTapOne: () => controller.changeSubscreen(true),
                        onTapTwo: () => controller.changeSubscreen(false),
                      ),
                    ),
                  ),
                  controller.displayResInvitorsPart
                      ? const ResInvitorsStatus()
                      : const OrderDetails(),
                  const SizedBox(height: 70)
                ],
              ))),
    );
  }
}

class HoldReservationTimer extends StatelessWidget {
  const HoldReservationTimer({super.key});

  @override
  Widget build(BuildContext context) {
    ReservationConfirmWaitController controller = Get.find();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            'من فضلك قم بتأكيد الحجز قبل انتهاء مدة التعليق المسموحة',
            textAlign: TextAlign.center,
            style: titleMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'الوقت المتبقي',
            style: titleSmall,
          ),
          const SizedBox(height: 12),
          Obx(() {
            int minutes = controller.remainingTime.value ~/ 60;
            int seconds = controller.remainingTime.value % 60;
            return Text(
              '$minutes دقيقة و $seconds ثانية',
              style: titleLarge,
            );
          }),
        ],
      ),
    );
  }
}

class ResInvitorsStatus extends StatelessWidget {
  const ResInvitorsStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationConfirmWaitController>(
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

class InvitorStatusListItem extends StatelessWidget {
  final Resinvitors resinvitor;

  const InvitorStatusListItem({super.key, required this.resinvitor});
  String displayResInvitorType(int? type) {
    switch (type) {
      case 0:
        return '( يدفع رسومه فقط )';
      case 1:
        return '( يقسم عليه رسوم المعزومين )';
      case 2:
        return '( معزوم )';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: resinvitor.status == 1
              ? Colors.green.withOpacity(0.1)
              : resinvitor.status == 2
                  ? Colors.red.withOpacity(0.1)
                  : AppColors.gray,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PersonImageAndName(
                  name: resinvitor.userName ?? '',
                  image: resinvitor.userImage ?? '',
                ),
              ),
              resinvitor.status == 0
                  ? Text(
                      'غير مؤكد',
                      style: titleSmall.copyWith(color: Colors.grey),
                    )
                  : resinvitor.status == 1
                      ? Text(
                          'مؤكد',
                          style: titleSmall.copyWith(color: Colors.green),
                        )
                      : resinvitor.status == 2
                          ? Text(
                              'رفض',
                              style: titleSmall.copyWith(
                                  color: AppColors.redButton),
                            )
                          : resinvitor.userid == resinvitor.creatorid
                              ? Text(
                                  'المدير',
                                  style: titleSmall.copyWith(
                                      color: AppColors.secondaryColor),
                                )
                              : const SizedBox()
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('الرسوم: ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
              Text('${resinvitor.cost} ريال',
                  style: TextStyle(fontSize: 13.sp)),
            ],
          ),
          if (resinvitor.status == 1)
            Text('تم تحويل المبلغ الى محفظتك',
                style: TextStyle(fontSize: 11.sp, color: Colors.green)),
          const SizedBox(height: 6),
          Text(displayResInvitorType(resinvitor.type),
              style: TextStyle(fontSize: 10.sp)),
        ],
      ),
    );
  }
}

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationConfirmWaitController>(
        builder: (controller) => Column(
              children: [
                const SizedBox(height: 20),
                CustomTitle(title: 'تفاصيل الطلب'.tr),
                const SizedBox(height: 15),
                const OrderContentTitle(),
                CartProduct(
                  statusRequest: controller.statusRequest,
                  carts: controller.carts,
                ),
                const SizedBox(height: 20),
                BillDetails(reservation: controller.reservation),
                const SizedBox(height: 20),
              ],
            ));
  }
}
