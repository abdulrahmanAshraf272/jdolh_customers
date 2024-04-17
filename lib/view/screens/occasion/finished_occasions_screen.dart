import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/appt_controller.dart';
import 'package:jdolh_customers/controller/occasion/finished_occasions_controller.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/functions/occasion_display_location.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class FinishedOccasionsScreen extends StatelessWidget {
  const FinishedOccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FinishedOccasionsController());

    return GetBuilder<FinishedOccasionsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'المناسبات السابقة'),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.occasionsToDisplay.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text('لا توجد مناسبات'),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.occasionsToDisplay.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) =>
                                  OccasionAcceptedListItem(
                                    from: controller.occasionsToDisplay[index]
                                        .occasionUsername!,
                                    title: controller.occasionsToDisplay[index]
                                        .occasionTitle!,
                                    date:
                                        '${controller.occasionsToDisplay[index].occasionDate} ${controller.timeInAmPm(index)}',
                                    location: controller
                                        .occasionsToDisplay[index]
                                        .occasionLocation!,
                                    creator: controller
                                        .occasionsToDisplay[index].creator!,
                                    onTapOpenLocation: () {
                                      onTapDisplayLocation(
                                          controller.occasionsToDisplay[index]);
                                    },
                                    onTapCard: () =>
                                        controller.onTapOccasionCard(index),
                                  )),
                    ),
                  )
                ],
              ),
            ));
  }
}
