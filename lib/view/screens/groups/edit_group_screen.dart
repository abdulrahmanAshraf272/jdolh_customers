import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/edit_group_controller.dart';
import 'package:jdolh_customers/controller/group/group_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
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
                    title: 'العنوان',
                    topPadding: 20,
                    bottomPadding: 10,
                  ),
                ),
                CustomButton(
                    onTap: () {
                      controller.showGroupNameDialog(context);
                    },
                    text: 'تعديل الاسم'),
                SizedBox(width: 20)
              ],
            ),
            DateOrLocationDisplayContainer(
                hintText: controller.groupSelected.groupName!),
            Row(
              children: [
                Expanded(
                  child: CustomSmallBoldTitle(
                    title: 'المضافين للمجموعة',
                    topPadding: 20,
                    bottomPadding: 20,
                  ),
                ),
                CustomButton(
                    onTap: () {
                      controller.onTapAddMember();
                    },
                    text: 'أضف للمجموعة'),
                SizedBox(width: 20)
              ],
            ),
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 70),
                  itemCount: controller.groupMembers.length,
                  itemBuilder: (context, index) => PersonWithButtonListItem(
                    name: controller.groupMembers[index].userName!,
                    userName: controller.groupMembers[index].userUsername!,
                    image: controller.groupMembers[index].userImage!,
                    onTap: () => controller.onTapRemoveMember(index),
                    onTapCard: () => controller.onTapPersonCard(index),
                    buttonColor: AppColors.redButton,
                    buttonText: textRemove,
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
            'حذف',
            style: titleSmall.copyWith(color: AppColors.redButton),
          ))
    ],
  );
}
