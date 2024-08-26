import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/edit_group_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class EditGroupScreen extends StatelessWidget {
  const EditGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditGroupController());
    return Scaffold(
      appBar: _appBarWithTextButton(
          onTapLeave: () => controller.onTapDeleteGroup()),
      // floatingActionButton: GoHomeButton(
      //   onTap: () {
      //     //controller.saveChanges();
      //   },
      //   text: 'حفظ',
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: GetBuilder<EditGroupController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSmallBoldTitle(
                    title: 'العنوان'.tr,
                    topPadding: 20,
                    bottomPadding: 10,
                  ),
                ),
                CustomButton(
                    onTap: () {
                      controller.showGroupNameDialog(context);
                    },
                    text: 'تعديل الاسم'.tr),
                const SizedBox(width: 20)
              ],
            ),
            DateOrLocationDisplayContainer(
                hintText: controller.groupSelected.groupName!),
            Row(
              children: [
                Expanded(
                  child: CustomSmallBoldTitle(
                    title: 'المضافين للمجموعة'.tr,
                    topPadding: 20,
                    bottomPadding: 20,
                  ),
                ),
                CustomButton(
                    onTap: () {
                      controller.onTapAddMembers();
                    },
                    text: 'أضف للمجموعة'.tr),
                const SizedBox(width: 20)
              ],
            ),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 70),
                  itemCount: controller.members.length,
                  itemBuilder: (context, index) => PersonWithButtonListItem(
                    name: controller.members[index].userName!,
                    userName: controller.members[index].userUsername!,
                    image: controller.members[index].userImage!,
                    onTap: () => controller.onTapRemoveMember(index),
                    onTapCard: () => controller.onTapPersonCard(index),
                    buttonColor: AppColors.redButton,
                    buttonText: 'إزالة'.tr,
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
      'المجموعة'.tr,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.white,
      ),
    ),
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
    ),
    actions: [
      TextButton(
          onPressed: onTapLeave,
          child: Text(
            'حذف'.tr,
            style: titleSmall.copyWith(color: AppColors.redButton),
          ))
    ],
  );
}
