import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/reservation_search_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/address_title.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';

import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
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
              appBar: customAppBar(
                title: 'الحجز',
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LargeToggleButtons(
                      optionOne: 'حجز تقليدي',
                      optionTwo: 'خدمات منزلية',
                      onTapOne: () => controller.setIsHomeService(false),
                      onTapTwo: () => controller.setIsHomeService(true)),
                  const SizedBox(height: 20),
                  const CustomSmallTitle(title: 'نوع المتجر'),
                  const DropdownBrandTypes(),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      const Expanded(
                          child: Column(
                        children: [
                          CustomSmallTitle(
                              title: 'النوع الفرعي', rightPdding: 0),
                          DropdownBrandSubtypes(),
                        ],
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        children: [
                          const CustomSmallTitle(
                              title: 'المدينة', rightPdding: 0),
                          CustomDropdown(
                            items: cities,
                            horizontalMargin: 0,
                            verticalMargin: 10,
                            withInitValue: true,
                            //width: Get.width / 2.2,
                            title: 'اختر المدينة',
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
                  AddressTitle(addressTitle: 'النتائج-25', onTap: () {}),
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
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
                                rate: 5.0,
                                image:
                                    '${ApiLinks.logoImage}/${controller.brands[index].brandLogo}',
                                onTap: () {
                                  controller.onTapCard(index);
                                },
                              )),
                    ),
                  )
                ],
              ),
            ));
  }
}
