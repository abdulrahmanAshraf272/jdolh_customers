import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/create_group_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateGroupController());
    return GetBuilder<CreateGroupController>(builder: (controller) {
      return Scaffold(
        appBar: customAppBar(title: 'انشاء مجموعة'.tr),
        floatingActionButton: BottomButton(
          onTap: () => controller.createGroup(),
          text: 'إنشاء'.tr,
          buttonColor: AppColors.secondaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSmallBoldTitle(
                title: 'العنوان'.tr,
                topPadding: 20,
                bottomPadding: 10,
              ),
              CustomTextField(
                  textEditingController: controller.groupName,
                  hintText: 'عنوان المجموعة'.tr),
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
              controller.members.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 70),
                        itemCount: controller.members.length,
                        itemBuilder: (context, index) =>
                            PersonWithButtonListItem(
                          name: controller.members[index].userName!,
                          userName: controller.members[index].userUsername!,
                          image: controller.members[index].userImage!,
                          onTap: () => controller.removeMember(index),
                          onTapCard: () {},
                          buttonColor: AppColors.redButton,
                          buttonText: 'إزالة'.tr,
                        ),
                        // Add separatorBuilder
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: '${'المجموعة فارغة!'.tr}\n',
                              style: TextStyle(
                                  color: AppColors.black.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo'),
                            ),
                            TextSpan(
                                text: 'اضف بعد الاصدقاء'.tr,
                                style: TextStyle(
                                    color: AppColors.black.withOpacity(0.4),
                                    fontSize: 14,
                                    fontFamily: 'Cairo'))
                          ])),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
