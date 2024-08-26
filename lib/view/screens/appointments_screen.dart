import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/appointments_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/convert_time_to_am_pm.dart';
import 'package:jdolh_customers/core/functions/occasion_display_location.dart';
import 'package:jdolh_customers/view/widgets/appointment/appointment_empty_result.dart';
import 'package:jdolh_customers/view/widgets/appointment/display_date.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentsController());
    return Scaffold(
        appBar: appBarWithButtonCreate(
            onTapCreate: () => controller.onTapCreate(),
            onTapBack: () => Get.back(),
            withArrowBack: false,
            title: 'جدولة'.tr,
            buttonText: 'انشاء مناسبة'.tr),
        body: GetBuilder<AppointmentsController>(
          builder: (controller) => RefreshIndicator(
            onRefresh: () async {
              controller.getAppointments();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LargeToggleButtons(
                    optionOne: 'جدولك القادم'.tr,
                    onTapOne: () =>
                        controller.changeDisplayCommingApptStatus(true),
                    optionTwo:
                        '${'بحاجة لموافقتك'.tr} (${controller.apptNeedApproveNo})',
                    onTapTwo: () =>
                        controller.changeDisplayCommingApptStatus(false),
                    twoColors: true,
                  ),
                  const SizedBox(height: 10),
                  if (controller.displayCommingAppt)
                    DisplayDate(
                      selectedDate: controller.arabicDate,
                      onTapDisplayAll: () => controller.displayAllAppointment(),
                      onTap: () {
                        controller.selectDate(context);
                      },
                    ),
                  const SizedBox(height: 10),
                  controller.resToDisplay.isEmpty &&
                          controller.occasionsToDisplay.isEmpty &&
                          controller.statusRequest == StatusRequest.success &&
                          controller.displayCommingAppt == true
                      ? AppointmentEmptyResult(
                          allDaysCount: controller.reservationComming.length +
                              controller.acceptedOccasions.length,
                          toDayCount: controller.resToDisplay.length +
                              controller.occasionsToDisplay.length)
                      : HandlingDataView(
                          emptyText: '',
                          statusRequest: controller.statusRequest,
                          widget: Column(
                            children: [
                              if (controller.resToDisplay.isNotEmpty)
                                CustomTitle(
                                  title: 'حجوزات'.tr,
                                  bottomPadding: 10,
                                ),
                              ListView.builder(
                                itemCount: controller.resToDisplay.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => controller
                                        .displayCommingAppt
                                    ? AppointmentListItem(
                                        brandName: controller
                                                .resToDisplay[index]
                                                .brandName ??
                                            '',
                                        brandLogo:
                                            '${ApiLinks.logoImage}/${controller.resToDisplay[index].brandLogo}',
                                        bchCity: controller
                                                .resToDisplay[index].bchCity ??
                                            '',
                                        dateTime:
                                            '${controller.resToDisplay[index].resDate} ${timeInAmPm(controller.resToDisplay[index].resTime!)}',
                                        onTap: () {
                                          controller
                                              .gotoReservationDetails(index);
                                        })
                                    : AppointmentListItemNotApproved(
                                        onTap: () => controller
                                            .gotoReservationDetails(index),
                                        reservation:
                                            controller.resToDisplay[index]),
                              ),
                              if (controller.occasionsToDisplay.isNotEmpty)
                                CustomTitle(
                                  topPadding: 10,
                                  bottomPadding: 0,
                                  title: 'مناسبات'.tr,
                                ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.occasionsToDisplay.length,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  itemBuilder: (context, index) => controller
                                              .displayCommingAppt ==
                                          false
                                      ? OccasionListItem(
                                          from: controller
                                              .occasionsToDisplay[index]
                                              .occasionUsername!,
                                          title: controller
                                              .occasionsToDisplay[index]
                                              .occasionTitle!,
                                          date:
                                              '${controller.occasionsToDisplay[index].occasionDate} ${timeInAmPm(controller.occasionsToDisplay[index].occasionTime!)}',
                                          location: controller
                                              .occasionsToDisplay[index]
                                              .occasionLocation!,
                                          creator: controller
                                              .occasionsToDisplay[index]
                                              .creator!,
                                          onTapAccept: () {
                                            controller.onTapAcceptInvitation(
                                                controller
                                                    .occasionsToDisplay[index]);
                                          },
                                          onTapReject: () {
                                            controller.onTapRejectInvitation(
                                                controller
                                                    .occasionsToDisplay[index]);
                                          },
                                          onTapCard: () => controller
                                              .onTapOccasionCard(index))
                                      : OccasionAcceptedListItem(
                                          from: controller
                                              .occasionsToDisplay[index]
                                              .occasionUsername!,
                                          title: controller
                                              .occasionsToDisplay[index]
                                              .occasionTitle!,
                                          date:
                                              '${controller.occasionsToDisplay[index].occasionDate} ${timeInAmPm(controller.occasionsToDisplay[index].occasionTime!)}',
                                          location: controller
                                              .occasionsToDisplay[index]
                                              .occasionLocation!,
                                          creator: controller
                                              .occasionsToDisplay[index]
                                              .creator!,
                                          onTapOpenLocation: () {
                                            onTapDisplayLocation(controller
                                                .occasionsToDisplay[index]);
                                          },
                                          onTapCard: () => controller
                                              .onTapOccasionCard(index),
                                        )),
                            ],
                          ))
                ],
              ),
            ),
          ),
        ));
  }
}
