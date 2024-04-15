import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/group_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupDetailsController());
    return Scaffold(
      appBar:
          _appBarWithTextButton(onTapLeave: () => controller.onTapLeaveGroup()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: GetBuilder<GroupDetailsController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSmallBoldTitle(
              title: 'العنوان',
              topPadding: 20,
              bottomPadding: 10,
            ),
            DateOrLocationDisplayContainer(
                hintText: controller.groupSelected.groupName!),
            CustomSmallBoldTitle(
              title: 'المضافين للمجموعة',
              topPadding: 20,
              bottomPadding: 20,
            ),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 70),
                  itemCount: controller.groupMembers.length,
                  itemBuilder: (context, index) => PersonWithTextListItem(
                    name: controller.groupMembers[index].userName!,
                    userName: controller.groupMembers[index].userUsername!,
                    image: controller.groupMembers[index].userImage!,
                    endText: controller.groupMembers[index].creator == 1
                        ? 'منشئ'
                        : '',
                    onTapCard: () => controller.onTapPersonCard(index),
                  ),
                  // Add separatorBuilder
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

AppBar _appBarWithTextButton({required void Function() onTapLeave}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      'المجموعة',
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
      TextButton(
          onPressed: onTapLeave,
          child: Text(
            'مغادرة',
            style: titleSmall.copyWith(color: AppColors.redButton),
          ))
    ],
  );
}
