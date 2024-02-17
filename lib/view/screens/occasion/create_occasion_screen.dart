import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/create_group_controller.dart';
import 'package:jdolh_customers/controller/occasion/create_occasion_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
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
    Get.put(CreateOccasionController());
    return GetBuilder<CreateOccasionController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء مناسبة'),
              floatingActionButton: BottomButton(
                onTap: () => controller.createOccasion(),
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
                    const CustomSmallBoldTitle(title: 'وقت المناسبة'),
                    DateOrLocationDisplayContainer(
                        hintText: 'اختر وقت و تاريخ الموعد',
                        iconData: Icons.date_range,
                        onTap: () async {
                          DateTime? dateTime = await showOmniDateTimePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1600)
                                .subtract(const Duration(days: 3652)),
                            lastDate: DateTime.now().add(
                              const Duration(days: 3652),
                            ),
                            is24HourMode: false,
                            isShowSeconds: false,
                            minutesInterval: 1,
                            secondsInterval: 1,
                            isForce2Digits: true,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            constraints: const BoxConstraints(
                              maxWidth: 350,
                              maxHeight: 650,
                            ),
                            transitionBuilder: (context, anim1, anim2, child) {
                              return FadeTransition(
                                opacity: anim1.drive(
                                  Tween(
                                    begin: 0,
                                    end: 1,
                                  ),
                                ),
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            barrierDismissible: true,
                            selectableDayPredicate: (dateTime) {
                              // Disable 25th Feb 2023
                              if (dateTime == DateTime(2023, 2, 25)) {
                                return false;
                              } else {
                                return true;
                              }
                            },
                          );

                          print("dateTime: $dateTime");
                        }),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'الموقع'),
                    DateOrLocationDisplayContainer(
                        hintText: 'عنوان المناسبة',
                        iconData: Icons.date_range,
                        onTap: () {}),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomSmallBoldTitle(
                              title: 'المضافين للمناسبة',
                              topPadding: 20,
                              bottomPadding: 20,
                            ),
                          ),
                          CustomButton(
                              onTap: () {
                                controller.onTapAddMembers();
                              },
                              text: 'أضف للمجموعة'),
                          SizedBox(width: 20)
                        ],
                      ),
                    ),
                    controller.membersId.isNotEmpty
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
                              onTap: () => controller.removeMember(index),
                              onTapCard: () {},
                              buttonColor: AppColors.redButton,
                              buttonText: textRemove,
                            ),
                            // Add separatorBuilder
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'المجموعة فارغة!\n',
                                style: TextStyle(
                                    color: AppColors.black.withOpacity(0.7),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                              TextSpan(
                                  text: 'اضف بعد الاصدقاء',
                                  style: TextStyle(
                                      color: AppColors.black.withOpacity(0.4),
                                      fontSize: 14,
                                      fontFamily: 'Cairo'))
                            ])),
                          ),
                  ],
                ),
              ),
            ));
  }
}
