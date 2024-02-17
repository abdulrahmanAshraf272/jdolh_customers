import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/appt_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ApptScreen extends StatelessWidget {
  const ApptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ApptController());
    return GetBuilder<ApptController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'مواعيدك'),
              body: Column(
                children: [
                  LargeToggleButtons(
                    optionOne: 'مواعيد قريبة',
                    onTapOne: () => controller.inactiveNeedAprrove(),
                    optionTwo: 'بحاجة لموافقتك',
                    onTapTwo: () => controller.activeNeedApprove(),
                    twoColors: true,
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.occasionToDisplay.length,
                        itemBuilder: (context, index) => controller.needApprove
                            ? OccasionListItem(
                                from: controller
                                    .occasionToDisplay[index].occasionUsername!,
                                title: controller
                                    .occasionToDisplay[index].occasionTitle!,
                                date: controller.occasionToDisplay[index]
                                    .occasionDatecreated!,
                                location: controller
                                    .occasionToDisplay[index].occasionLocation!,
                                creator: controller
                                    .occasionToDisplay[index].creator!,
                                onTapAccept: () {},
                                onTapReject: () {},
                                onTapCard: () {},
                              )
                            : OccasionAcceptedListItem(
                                from: controller
                                    .occasionToDisplay[index].occasionUsername!,
                                title: controller
                                    .occasionToDisplay[index].occasionTitle!,
                                date: controller.occasionToDisplay[index]
                                    .occasionDatecreated!,
                                location: controller
                                    .occasionToDisplay[index].occasionLocation!,
                                creator: controller
                                    .occasionToDisplay[index].creator!,
                                onTapOpenLocation: () {},
                                onTapCard: () {},
                              )),
                  ),
                ],
              ),
            ));
  }
}
