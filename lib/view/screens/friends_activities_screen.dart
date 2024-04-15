import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/friends_activity_controller.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class FriendsActivitiesScreen extends StatelessWidget {
  const FriendsActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FriendsActivitiesController());
    return Scaffold(
      appBar: customAppBar(
        title: controller.appBarTitle(),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: controller.friendsActivities.length,
                  itemBuilder: (context, index) => ActivityListItem(
                        cardStatus: controller.pageStatus,
                        activity: controller.friendsActivities[index],
                        onTapLike: () {
                          if (controller.friendsActivities[index].isLiked ==
                              1) {
                            controller.friendsActivities[index].isLiked = 0;
                          } else {
                            controller.friendsActivities[index].isLiked = 1;
                          }
                        },
                      ))),
        ],
      ),
    );
  }
}
