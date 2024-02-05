import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class FriendsActivitiesScreen extends StatelessWidget {
  const FriendsActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'نشاطات اللأصدقاء',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => ActivityListItem(),
              separatorBuilder: (context, index) => Container(
                color: AppColors.gray450,
                height: 2,
                width: Get.width,
              ), // Add separatorBuilder
            ),
          ),
        ],
      ),
    );
  }
}
