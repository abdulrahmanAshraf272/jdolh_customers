import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_home_services_subscreen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_product_subcreen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_service_subscreen.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/categories.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/desc_branchesButton_workTime.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/header.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/items_to_display.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandProfileController());
    return GetBuilder<BrandProfileController>(
        builder: (controller) => Scaffold(
            floatingActionButton: controller.subscreen == 0
                ? GoHomeButton(
                    onTap: () => controller.displayResSubscreen(),
                    text: 'التالي'.tr,
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: controller.statusRequest != StatusRequest.success
                ? HandlingDataView2(statusRequest: controller.statusRequest)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        BrandProfileHeader(
                          isFollowing: controller.isFollowing,
                          followingNo: controller.followingNo,
                          ratesNo: controller.rates.length,
                          averageRate: controller.averageRate,
                          scheduledNo: controller.scheduledUsers.length,
                          onTapFollow: () => controller.followUnfollow(),
                          onTapRates: () => controller.onTapRates(),
                          onTapScheduled: () => controller.onTapScheduled(),
                        ),
                        DescAndBranshedButtonAndWorkTime(
                          desc: controller.bch.bchDesc ?? '',
                          onTapWorktime: () => controller.gotoDisplayWorktime(),
                          onTapBchs: () => controller.goDisplayAllBchs(),
                        ),
                        LargeToggleButtonsBrandProfile(
                            optionOne: controller.brand.brandIsService == 1
                                ? 'الخدمات'.tr
                                : 'القائمة'.tr,
                            optionTwo: 'تفاصيل الحجز'.tr,
                            optionSelected: controller.subscreen == 0 ? 0 : 1,
                            onTapOne: () => controller.diplayItemsSubscreen(),
                            onTapTwo: () => controller.displayResSubscreen()),
                        // LargeToggleButtons(
                        //     optionOne: controller.brand.brandIsService == 1
                        //         ? 'الخدمات'.tr
                        //         : 'القائمة'.tr,
                        //     optionTwo: 'تفاصيل الحجز'.tr,
                        //     onTapOne: () => controller.diplayItemsSubscreen(),
                        //     onTapTwo: () => controller.displayResSubscreen()),
                        controller.subscreen == 0
                            ? const Column(
                                children: [
                                  Categories(),
                                  ItemsToDisplay(),
                                ],
                              )
                            : controller.subscreen == 1
                                ? const ResProductSubscreen()
                                : controller.subscreen == 2
                                    ? const ResServiceSubscreen()
                                    : const ResHomeServicesSubscreen(),
                      ],
                    ),
                  )));
  }
}
