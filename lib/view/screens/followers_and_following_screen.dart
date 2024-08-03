import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/followersAndFollowingController.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/search_app_bar.dart';

class FollowersAndFollowingScreen extends StatefulWidget {
  final String title;
  final List<Friend> data;

  const FollowersAndFollowingScreen(
      {super.key, required this.title, required this.data});

  @override
  State<FollowersAndFollowingScreen> createState() =>
      _FollowersAndFollowingScreenState();
}

class _FollowersAndFollowingScreenState
    extends State<FollowersAndFollowingScreen> {
  MyServices myServices = Get.find();
  late int myId;

  @override
  void initState() {
    myId = int.parse(myServices.getUserid());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FollowersAndFollowingController());
    controller.data = List.from(widget.data);
    return GetBuilder<FollowersAndFollowingController>(
      builder: (controller) => Scaffold(
        appBar: customAppBar(title: widget.title),
        body: Column(
          children: [
            SearchAppBar(
              textEditingController: controller.name,
              withArrowBack: false,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 30, top: 10),
                itemCount: controller.data.length,
                itemBuilder: (context, index) => PersonWithButtonListItem(
                  isThisMe: myId == controller.data[index].userId,
                  name: controller.data[index].userName!,
                  userName: controller.data[index].userUsername!,
                  image: controller.data[index].userImage!,
                  buttonText: controller.data[index].following!
                      ? 'الغاء المتابعة'.tr
                      : 'متابعة'.tr,
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
