import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/followersAndFollowingController.dart';
import 'package:jdolh_customers/controller/person_profile_controller.dart';
import 'package:jdolh_customers/controller/search_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/search_app_bar.dart';

class FollowersAndFollowingScreen extends StatelessWidget {
  final String title;
  final List<PersonWithFollowState> data;
  const FollowersAndFollowingScreen(
      {super.key, required this.title, required this.data});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FollowersAndFollowingController());
    controller.data = data;
    return GetBuilder<FollowersAndFollowingController>(
      builder: (controller) => Scaffold(
        appBar: customAppBar(title: title),
        body: Column(
          children: [
            SearchAppBar(
              onTapSearch: () {},
              textEditingController: controller.name,
              withArrowBack: false,
            ),
            Expanded(
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
            )
          ],
        ),
      ),
    );
  }
}
