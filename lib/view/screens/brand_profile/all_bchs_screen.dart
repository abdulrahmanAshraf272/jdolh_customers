import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/brand_profile/all_bchs_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class AllBchsScreen extends StatelessWidget {
  const AllBchsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AllBchsController());
    return Scaffold(
      appBar: customAppBar(title: 'الفروع'),
      body: GetBuilder<AllBchsController>(
          builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.brands.length,
                          itemBuilder: (context, index) =>
                              BrandDetailedListItem(
                                brandName:
                                    controller.brands[index].brandStoreName ??
                                        '',
                                type: controller.brands[index].brandType ?? '',
                                subtype:
                                    controller.brands[index].brandSubtype ?? '',
                                isVerified:
                                    controller.brands[index].brandIsVerified ??
                                        0,
                                address: controller.bchs[index].bchCity ?? '',
                                rate: controller.bchs[index].rate ?? 0,
                                image:
                                    '${ApiLinks.logoImage}/${controller.brands[index].brandLogo}',
                                onTap: () {
                                  controller.onTapCard(index);
                                },
                              )),
                    ),
                  ],
                ),
              )),
    );
  }
}
