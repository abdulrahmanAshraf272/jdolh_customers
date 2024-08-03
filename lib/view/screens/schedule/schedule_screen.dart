import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/schedule/schedule_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleController());
    return Scaffold(
        appBar: customAppBar(title: 'الحجوزات'.tr),
        body: GetBuilder<ScheduleController>(
          builder: (controller) => RefreshIndicator(
            onRefresh: () async {
              controller.getAllRes();
            },
            child: Column(
              children: [
                LargeToggleButtons(
                  optionOne: 'حجوزات قادمة'.tr,
                  onTapOne: () => controller.setDisplayCommingRes(1),
                  optionTwo:
                      '${'بحاجة لموافقتك'.tr} (${controller.reservationNeedApproval.length})',
                  onTapTwo: () => controller.setDisplayCommingRes(0),
                  twoColors: true,
                ),
                const SizedBox(height: 10),
                if (controller.diplayCommingRes == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DisplayDate(
                      selectedDate: controller.arabicDate,
                      onTap: () {
                        controller.selectDate(context);
                      },
                    ),
                  ),
                if (controller.diplayCommingRes == 1)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 15, left: 5),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                '${'الحجوزات القادمة:'.tr} ${controller.reservationComming.length}',
                                style: titleSmall)),
                        TextButton(
                            onPressed: () =>
                                controller.displayAllCommingReservations(),
                            child: Text(
                              'عرض الكل'.tr,
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 11.sp),
                            ))
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: HandlingDataView(
                      emptyText: '',
                      statusRequest: controller.statusRequest,
                      widget: controller.resToDisplay.isEmpty &&
                              controller.diplayCommingRes == 1
                          ? DisplayEmptyResult(
                              allDaysCount:
                                  controller.reservationComming.length,
                              toDayCount: controller.resToDisplay.length)
                          : ListView.builder(
                              itemCount: controller.resToDisplay.length,
                              itemBuilder: (context, index) => controller
                                          .diplayCommingRes ==
                                      1
                                  ? AppointmentListItem(
                                      brandName: controller
                                              .resToDisplay[index].brandName ??
                                          '',
                                      brandLogo:
                                          '${ApiLinks.logoImage}/${controller.resToDisplay[index].brandLogo}',
                                      bchCity: controller
                                              .resToDisplay[index].bchCity ??
                                          '',
                                      dateTime:
                                          '${controller.resToDisplay[index].resDate} ${controller.resToDisplay[index].resTime}',
                                      onTap: () {
                                        controller
                                            .gotoReservationDetails(index);
                                      })
                                  : AppointmentListItemNotApproved(
                                      onTap: () => controller
                                          .gotoReservationDetails(index),
                                      reservation:
                                          controller.resToDisplay[index]),
                            )),
                )
              ],
            ),
          ),
        ));
  }
}

class DisplayEmptyResult extends StatelessWidget {
  final int allDaysCount;
  final int toDayCount;
  const DisplayEmptyResult(
      {super.key, required this.allDaysCount, required this.toDayCount});

  @override
  Widget build(BuildContext context) {
    return toDayCount == 0 && allDaysCount == 0
        ? Center(child: Text('لا توجد حجوزات قادمة'.tr))
        : toDayCount == 0 && allDaysCount != 0
            ? Center(child: Text('لا توجد حجوزات في هذا اليوم'.tr))
            : const SizedBox();
  }
}

class DisplayDate extends StatelessWidget {
  final void Function() onTap;
  final String selectedDate;
  const DisplayDate({
    super.key,
    required this.onTap,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(20)),
        child: AutoSizeText(
          selectedDate,
          maxLines: 1,
          style: headline4,
        ),
      ),
    );
  }
}

// ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) => AppointmentListItem(onTap: () {
//                       Get.toNamed(AppRouteName.apptDetails);
//                     })),

//             ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) =>
//                     AppointmentListItemNotApproved()),

// CalendarDatePicker2(
//   config: CalendarDatePicker2Config(
//     calendarType: CalendarDatePicker2Type.single,
//   ),
//   value: _dates,
//   onValueChanged: (dates) {
//     _dates = dates;
//     setState(() {});
//   },
// ),

