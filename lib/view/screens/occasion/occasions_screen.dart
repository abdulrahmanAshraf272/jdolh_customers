import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/appt_controller.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
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
                  title: 'مناسباتك',
                  buttonText: 'انشاء مناسبة'),
              body: Column(
                children: [
                  LargeToggleButtons(
                    optionOne: 'مناسبات قريبة',
                    onTapOne: () => controller.inactiveNeedAprrove(),
                    optionTwo: 'بحاجة لموافقتك',
                    onTapTwo: () => controller.activeNeedApprove(),
                    twoColors: true,
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.occasionsToDisplay.length,
                        itemBuilder: (context, index) => controller.needApprove
                            ? OccasionListItem(
                                from: controller.occasionsToDisplay[index]
                                    .occasionUsername!,
                                title: controller
                                    .occasionsToDisplay[index].occasionTitle!,
                                date: controller.occasionsToDisplay[index]
                                    .occasionDatecreated!,
                                location: controller.occasionsToDisplay[index]
                                    .occasionLocation!,
                                creator: controller
                                    .occasionsToDisplay[index].creator!,
                                onTapAccept: () {},
                                onTapReject: () {},
                                onTapCard: () =>
                                    controller.onTapOccasionCard(index))
                            : OccasionAcceptedListItem(
                                from: controller.occasionsToDisplay[index]
                                    .occasionUsername!,
                                title: controller
                                    .occasionsToDisplay[index].occasionTitle!,
                                date: controller.occasionsToDisplay[index]
                                    .occasionDatecreated!,
                                location: controller.occasionsToDisplay[index]
                                    .occasionLocation!,
                                creator: controller
                                    .occasionsToDisplay[index].creator!,
                                onTapOpenLocation: () {},
                                onTapCard: () =>
                                    controller.onTapOccasionCard(index),
                              )),
                  ),
                ],
              ),
            ));
  }
}
