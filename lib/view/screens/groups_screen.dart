import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/group.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: groupsAppBar(onTapCreateGroup: () {
        Get.toNamed(AppRouteName.createAndEditGroup);
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 30, top: 20),
              itemCount: 12,
              itemBuilder: (context, index) => GroupListItem(onTap: () {
                Get.toNamed(AppRouteName.addToGroup);
              }),
              // Add separatorBuilder
            ),
          ),
        ],
      ),
    );
  }
}

AppBar groupsAppBar({required void Function() onTapCreateGroup}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      'المجموعات',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.white,
      ),
    ),
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(9.0),
        child: CustomButton(onTap: onTapCreateGroup, text: 'انشاء مجموعة'),
      )
    ],
  );
}
