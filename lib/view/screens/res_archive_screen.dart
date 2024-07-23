import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/res_archive_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ResArchiveScreen extends StatelessWidget {
  const ResArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResArchiveController());
    return Scaffold(
        appBar: customAppBar(title: 'الحجوزات السابقة'.tr),
        body: GetBuilder<ResArchiveController>(
          builder: (controller) => RefreshIndicator(
            onRefresh: () async {
              await controller.getAllRes();
              controller.setResToDisplay();
            },
            child: Column(
              children: [
                LargeToggleButtons(
                  optionOne: 'حجوزات منتهية'.tr,
                  onTapOne: () => controller.setDisplayFinishedRes(1),
                  optionTwo: 'حجوزات ملغية'.tr,
                  onTapTwo: () => controller.setDisplayFinishedRes(0),
                  twoColors: true,
                ),
                HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: controller.resToDisplay.isEmpty
                        ? Text('لا توجد حجوزات'.tr)
                        : Expanded(
                            child: ListView.builder(
                                itemCount: controller.resToDisplay.length,
                                itemBuilder: (context, index) =>
                                    AppointmentListItem(
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
