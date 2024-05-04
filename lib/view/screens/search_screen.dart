import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/search_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
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
              // onTapSearch: () {
              //   controller.seachOnTap(value);
              // },
              autoFocus: true,
            ),
            // LargeToggleButtons(
            //     optionOne: 'اشخاص',
            //     optionTwo: 'اماكن',
            //     onTapOne: () => controller.activePersonSearch(),
            //     onTapTwo: () => controller.inactivePersonSearch()),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) => PersonWithButtonListItem(
                    name: controller.data[index].userName!,
                    userName: controller.data[index].userUsername!,
                    image: controller.data[index].userImage!,
                    buttonText: controller.data[index].following!
                        ? textUnfollow
                        : textFollow,
                    buttonColor: controller.data[index].following!
                        ? AppColors.redButton
                        : AppColors.secondaryColor,
                    onTap: () => controller.followUnfollow(index),
                    onTapCard: () => controller.onTapCard(index),
                  ),
                  // Add separatorBuilder
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
