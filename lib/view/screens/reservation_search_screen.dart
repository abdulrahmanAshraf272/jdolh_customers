import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/reservation_search_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/strings.dart';

import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/address_title.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/reservation_search/dropdown_brand_subtype.dart';
import 'package:jdolh_customers/view/widgets/reservation_search/dropdown_brand_type.dart';
import 'package:jdolh_customers/view/widgets/reservation_search/search_button.dart';

class ReservationSearchScreen extends StatelessWidget {
  const ReservationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReservationSearchController());
    return GetBuilder<ReservationSearchController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'الحجز'.tr, withBack: false),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeToggleButtons(
                        optionOne: 'حجز تقليدي'.tr,
                        optionTwo: 'خدمات منزلية'.tr,
                        onTapOne: () => controller.setIsHomeService(false),
                        onTapTwo: () => controller.setIsHomeService(true)),
                    const SizedBox(height: 20),
                    CustomSmallTitle(title: 'نوع المتجر'.tr),
                    const DropdownBrandTypes(),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                            child: Column(
                          children: [
                            CustomSmallTitle(
                                title: 'النوع الفرعي'.tr, rightPdding: 0),
                            const DropdownBrandSubtypes(),
                          ],
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          children: [
                            CustomSmallTitle(
                                title: 'المدينة'.tr, rightPdding: 0),
                            CustomDropdown(
                              items: cities,
                              horizontalMargin: 0,
                              verticalMargin: 10,
                              withInitValue: true,
                              //width: Get.width / 2.2,
                              title: 'اختر المدينة'.tr,
                              onChanged: (String? value) {
                                // Handle selected value
                                controller.city = value!;
                                print(value);
                              },
                            ),
                          ],
                        )),
                        const SizedBox(width: 20),
                      ],
                    ),
                    SearchButton(onTap: () => controller.searchBrand()),
                    AddressTitle(
                        addressTitle:
                            '${'النتائج-'.tr} ${controller.brands.length}',
                        onTap: () => controller.onTapDisplayOnTap()),
                    HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.brands.length,
                          shrinkWrap: true,
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
                    )
                  ],
                ),
              ),
            ));
  }
}
