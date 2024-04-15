import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/schedule/schedule_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
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
        appBar: customAppBar(title: 'الحجوزات'),
        body: GetBuilder<ScheduleController>(
          builder: (controller) => RefreshIndicator(
            onRefresh: () async {
              await controller.getAllRes();
              controller.setResToDisplay(controller.diplayCommingRes);
            },
            child: Column(
              children: [
                LargeToggleButtons(
                  optionOne: 'حجوزات قادمة',
                  onTapOne: () => controller.setDisplayCommingRes(1),
                  optionTwo: 'بحاجة لموافقتك',
                  onTapTwo: () => controller.setDisplayCommingRes(0),
                  twoColors: true,
                ),
                const SizedBox(height: 10),
                if (controller.diplayCommingRes == 1)
                  DisplayDate(
                    selectedDate: controller.arabicDate,
                    onTap: () {
                      controller.selectDate(context);
                    },
                  ),
                const SizedBox(height: 10),
                if (controller.resToDisplay.isEmpty)
                  const Center(child: Text('لا توجد حجوزات')),
                if (controller.resToDisplay.isNotEmpty)
                  HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: Expanded(
                          child: ListView.builder(
                              itemCount: controller.resToDisplay.length,
                              itemBuilder: (context, index) =>
                                  AppointmentListItem(
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
                                      }))))
              ],
            ),
          ),
        ));
  }
}

// ResListItem(
//                                     onTapCard: () {
//                                       controller.gotoReservationDetails(index);
//                                     },
//                                     resNumber:
//                                         controller.resToDisplay[index].resId ??
//                                             0,
//                                     resTime: controller.displayResTime(index),
//                                     resOption: controller
//                                             .resToDisplay[index].resResOption ??
//                                         '')

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

