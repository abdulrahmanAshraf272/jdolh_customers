import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/search_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/search_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SearchScreenController());
    return Scaffold(
      body: GetBuilder<SearchScreenController>(
        builder: (controller) => Column(
          children: [
            SearchAppBar(
              textEditingController: controller.name,
              onChaneged: (value) => controller.seachOnTap(value),
              autoFocus: true,
              hintText: controller.isPersonSearch
                  ? 'اكتب اسم الشخص'.tr
                  : 'اكتب اسم المتجر'.tr,
            ),
            LargeToggleButtons(
                optionOne: 'اشخاص'.tr,
                optionTwo: 'اماكن'.tr,
                onTapOne: () => controller.activePersonSearch(),
                onTapTwo: () => controller.inactivePersonSearch()),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: controller.isPersonSearch
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        itemCount: controller.usersSearched.length,
                        itemBuilder: (context, index) =>
                            PersonWithButtonListItem(
                          name: controller.usersSearched[index].userName!,
                          userName:
                              controller.usersSearched[index].userUsername!,
                          image: controller.usersSearched[index].userImage!,
                          buttonText: controller.usersSearched[index].following!
                              ? 'الغاء المتابعة'.tr
                              : 'متابعة'.tr,
                          buttonColor:
                              controller.usersSearched[index].following!
                                  ? AppColors.redButton
                                  : AppColors.secondaryColor,
                          onTap: () => controller.followUnfollow(index),
                          onTapCard: () => controller.onTapUser(index),
                        ),
                        // Add separatorBuilder
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: controller.brandAndBchSearched.length,
                        itemBuilder: (context, index) => BrandDetailedListItem(
                          brandName: controller
                                  .brandAndBchSearched[index].brandStoreName ??
                              '',
                          type:
                              controller.brandAndBchSearched[index].brandType ??
                                  '',
                          subtype: controller
                                  .brandAndBchSearched[index].brandSubtype ??
                              '',
                          isVerified: controller
                                  .brandAndBchSearched[index].brandIsVerified ??
                              0,
                          address:
                              controller.brandAndBchSearched[index].bchCity ??
                                  '',
                          rate: controller.brandAndBchSearched[index].rate ?? 0,
                          image:
                              '${ApiLinks.logoImage}/${controller.brandAndBchSearched[index].brandLogo}',
                          onTap: () {
                            controller.onTapStore(index);
                          },
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
