import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/functions/occasion_display_location.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';

class OccasionsScreen extends StatelessWidget {
  const OccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OccasionsController());

    return GetBuilder<OccasionsController>(
        builder: (controller) => Scaffold(
              appBar: appBarWithButtonCreate(
                  onTapCreate: () => controller.onTapCreate(),
                  onTapBack: () => Get.back(),
                  title: 'المناسبات'.tr,
                  buttonText: 'انشاء مناسبة'.tr),
              body: RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshGetOccasions();
                },
                child: ListView(
                  children: [
                    LargeToggleButtons(
                      optionOne: 'مناسبات قريبة'.tr,
                      onTapOne: () => controller.inactiveNeedAprrove(),
                      optionTwo:
                          '${'بحاجة لموافقتك'.tr}(${controller.needApproveOccasionsNo})',
                      onTapTwo: () => controller.activeNeedApprove(),
                      twoColors: true,
                    ),
                    HandlingDataView(
                      emptyText: 'لا توجد مناسبات'.tr,
                      statusRequest: controller.statusRequest,
                      widget: controller.occasionsToDisplay.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Text('لا توجد مناسبات'.tr)),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.occasionsToDisplay.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) => controller
                                      .needApprove
                                  ? OccasionListItem(
                                      from: controller.occasionsToDisplay[index]
                                          .occasionUsername!,
                                      title: controller
                                          .occasionsToDisplay[index]
                                          .occasionTitle!,
                                      date:
                                          '${controller.occasionsToDisplay[index].occasionDate} ${controller.timeInAmPm(index)}',
                                      location: controller
                                          .occasionsToDisplay[index]
                                          .occasionLocation!,
                                      creator: controller
                                          .occasionsToDisplay[index].creator!,
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
                                      onTapCard: () =>
                                          controller.onTapOccasionCard(index))
                                  : OccasionAcceptedListItem(
                                      from: controller.occasionsToDisplay[index]
                                          .occasionUsername!,
                                      title: controller
                                          .occasionsToDisplay[index]
                                          .occasionTitle!,
                                      date:
                                          '${controller.occasionsToDisplay[index].occasionDate} ${controller.timeInAmPm(index)}',
                                      location: controller
                                          .occasionsToDisplay[index]
                                          .occasionLocation!,
                                      creator: controller
                                          .occasionsToDisplay[index].creator!,
                                      onTapOpenLocation: () {
                                        onTapDisplayLocation(controller
                                            .occasionsToDisplay[index]);
                                      },
                                      onTapCard: () =>
                                          controller.onTapOccasionCard(index),
                                    )),
                    )
                  ],
                ),
              ),
            ));
  }
}
