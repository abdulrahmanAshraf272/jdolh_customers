import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_product_subcreen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_service_subscreen.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/categories.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/desc_branchesButton_workTime.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/header.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/items_to_display.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/products.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/services.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandProfileController());
    return Scaffold(
      appBar: customAppBar(title: controller.brand.brandStoreName ?? ''),
      body: GetBuilder<BrandProfileController>(
        builder: (controller) => Column(
          children: [
            BrandProfileHeader(onTapFollow: () {}),
            DescAndBranshedButtonAndWorkTime(
              desc: controller.bch.bchDesc ?? '',
              onTapWorktime: () {},
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
                ? HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: const Expanded(
                      child: Column(
                        children: [
                          Categories(),
                          Expanded(child: ItemsToDisplay())
                        ],
                      ),
                    ))
                : controller.subscreen == 1
                    ? ResProductSubscreen()
                    : ResServiceSubscreen()
          ],
        ),
      ),
    );
  }
}
