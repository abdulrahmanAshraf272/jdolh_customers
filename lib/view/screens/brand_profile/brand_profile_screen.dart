import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_home_services_subscreen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_product_subcreen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_service_subscreen.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/categories.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/desc_branchesButton_workTime.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/header.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/items_to_display.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BrandProfileController());
    return Scaffold(
      //appBar: customAppBar(title: controller.brand.brandStoreName ?? ''),
      body: GetBuilder<BrandProfileController>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    BrandProfileHeader(
                        isFollowing: controller.isFollowing,
                        onTapFollow: () => controller.followUnfollow()),
                    DescAndBranshedButtonAndWorkTime(
                      desc: controller.bch.bchDesc ?? '',
                      onTapWorktime: () => controller.gotoDisplayWorktime(),
                      onTapBchs: () {},
                    ),
                    LargeToggleButtons(
                        optionOne: controller.brand.brandIsService == 1
                            ? 'الخدمات'
                            : 'القائمة',
                        optionTwo: 'تفاصيل الحجز',
                        onTapOne: () => controller.diplayItemsSubscreen(),
                        onTapTwo: () => controller.displayResSubscreen()),
                    controller.subscreen == 0
                        ? const Expanded(
                            child: Column(
                              children: [
                                Categories(),
                                Expanded(child: ItemsToDisplay())
                              ],
                            ),
                          )
                        : controller.subscreen == 1
                            ? const Expanded(child: ResProductSubscreen())
                            : controller.subscreen == 2
                                ? const Expanded(child: ResServiceSubscreen())
                                : const Expanded(
                                    child: ResHomeServicesSubscreen())
                  ],
                ),
              )),
    );
  }
}
