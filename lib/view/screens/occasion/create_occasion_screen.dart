import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/create_group_controller.dart';
import 'package:jdolh_customers/controller/occasion/create_occasion_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/view/widgets/add_group_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class CreateOccasionScreen extends StatelessWidget {
  const CreateOccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // dataSavedSuccessfuly() {
    //   AwesomeDialog(
    //     context: context,
    //     dialogType: DialogType.success,
    //     animType: AnimType.rightSlide,
    //     title: 'تم انشاء المناسبة',
    //     btnOkText: 'حسنا',
    //     btnOkOnPress: () {
    //       Get.back();
    //     },
    //   ).show();
    // }

    Get.put(CreateOccasionController());
    return GetBuilder<CreateOccasionController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء مناسبة'),
              floatingActionButton: BottomButton(
                onTap: () async {
                  controller.createOccasion();
                },
                text: 'انشاء',
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
                    const CustomSmallBoldTitle(title: 'تاريخ المناسبة'),
                    DateOrLocationDisplayContainer(
                      hintText: controller.selectedDateFormatted ??
                          'اختر تاريخ المناسبة',
                      iconData: Icons.date_range,
                      onTap: () {
                        controller.selectDate(context);
                      },
                    ),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'وقت المناسبة'),
                    DateOrLocationDisplayContainer(
                      hintText: controller.timeInAmPm(),
                      iconData: Icons.date_range,
                      onTap: () {
                        controller.showCustomTimePicker(context);
                      },
                    ),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'الموقع'),
                    DateOrLocationDisplayContainer(
                        hintText: controller.occasionLocation == ''
                            ? 'حدد موقع المناسبة'
                            : controller.occasionLocation,
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
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomSmallBoldTitle(
                              title: 'المدعوين للمناسبة',
                              topPadding: 20,
                              bottomPadding: 20,
                            ),
                          ),
                          CustomButton(
                              onTap: () {
                                controller.onTapAddMembers();
                              },
                              text: 'إضافة مدعوين'),
                          SizedBox(width: 20)
                        ],
                      ),
                    ),
                    if (controller.groups.isNotEmpty) const AllGroups(),
                    controller.members.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 70),
                            shrinkWrap: true,
                            itemCount: controller.members.length,
                            itemBuilder: (context, index) =>
                                PersonWithButtonListItem(
                              name: controller.members[index].userName!,
                              userName: controller.members[index].userUsername!,
                              image: controller.members[index].userImage!,
                              onTap: () => controller.onTapRemoveMember(index),
                              onTapCard: () {},
                              buttonColor: AppColors.redButton,
                              buttonText: textRemove,
                            ),
                            // Add separatorBuilder
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 60),
                            child: controller.groups.isEmpty
                                ? RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'لا يوجد اصدقاء في المناسبة!\n',
                                        style: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.7),
                                            fontSize: 14,
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
                                    ]))
                                : SizedBox(),
                          ),
                  ],
                ),
              ),
            ));
  }
}

class AllGroups extends StatelessWidget {
  const AllGroups({
    super.key,
  });
  Color getRandomColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.amber;
      case 2:
        return Colors.purple;
      case 4:
        return Colors.indigo;
      case 5:
        return Colors.orange;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateOccasionController>(
        builder: (controller) => SizedBox(
              height: 100.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.groups.length,
                  itemBuilder: (context, index) => AddGroupListItem(
                        groupName: controller.groups[index].groupName ?? '',
                        groupColor: getRandomColor(index),
                        isAdd: false,
                        onTap: () => controller.onTapDeleteGroup(index),
                      )),
            ));
  }
}
