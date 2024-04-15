import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/occasion/edit_occasion_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button_and_status.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class EditOccasionScreen extends StatelessWidget {
  const EditOccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dataSavedSuccessfuly() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'تم حفظ البيانات',
        btnOkText: 'حسنا',
        btnOkOnPress: () {
          Get.back();
        },
      ).show();
    }

    Get.put(EditOccasionController());
    return GetBuilder<EditOccasionController>(
        builder: (controller) => Scaffold(
              appBar: _appBarWithTextButton(
                  onTapLeave: () => controller.onTapDeleteOccasion()),
              floatingActionButton: BottomButton(
                onTap: () async {
                  var result = await controller.editOccasion();
                  if (result == true) {
                    dataSavedSuccessfuly();
                  }
                },
                text: 'حفظ',
                buttonColor: AppColors.secondaryColor,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'عنوان المناسبة'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.occasionTitle,
                        hintText: 'مثال: عشاء, عيد ميلاد, ..'),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'وقت المناسبة'),
                    DateOrLocationDisplayContainer(
                        hintText: controller.occasionDateTime == ''
                            ? 'اختر وقت و تاريخ الموعد'
                            : controller.occasionDateTime,
                        iconData: Icons.date_range,
                        onTap: () {
                          controller.pickDateTime(context);
                        }),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'الموقع'),
                    DateOrLocationDisplayContainer(
                        hintText: controller.occasionLocation,
                        iconData: Icons.place,
                        onTap: () {
                          controller.goToAddLocation();
                        }),
                    const CustomSmallBoldTitle(title: 'رابط الموقع'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.locationLink,
                        hintText: 'يمكنك اضافة رابط الموقع من خرائط جوجل'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          const Expanded(
                            child: CustomSmallBoldTitle(
                              title: 'المدعوين للمناسبة',
                              topPadding: 20,
                              bottomPadding: 20,
                              rightPdding: 0,
                              leftPadding: 0,
                            ),
                          ),
                          CustomButton(
                              onTap: () {
                                controller.onTapAddMembers();
                              },
                              text: 'إضافة مدعوين'),
                        ],
                      ),
                    ),
                    HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: controller.members.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 70),
                              shrinkWrap: true,
                              itemCount: controller.members.length,
                              itemBuilder: (context, index) =>
                                  PersonWithButtonAndStatus(
                                name: controller.members[index].userName!,
                                userName:
                                    controller.members[index].userUsername!,
                                image: controller.members[index].userImage!,
                                onTap: () =>
                                    controller.onTapRemoveMember(index),
                                onTapCard: () {},
                                buttonColor: AppColors.redButton,
                                buttonText: textRemove,
                                invitorStatus:
                                    controller.displayMemberStatus(index),
                                statusColor:
                                    controller.displayMemberStatusColor(index),
                              ),
                              // Add separatorBuilder
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'لا يوجد مدعويين للمناسبة!\n',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                    ),
                                    TextSpan(
                                        text: 'اضف بعد الاصدقاء',
                                        style: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontSize: 14,
                                            fontFamily: 'Cairo'))
                                  ])),
                            ),
                    )
                  ],
                ),
              ),
            ));
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
