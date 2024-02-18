import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/occasion/edit_occasion_controller.dart';
import 'package:jdolh_customers/controller/occasion/occasion_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/formatDateTime.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/confirm_refuse_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class OccasionDetailsScreen extends StatelessWidget {
  const OccasionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OccasionDetailsController());
    return GetBuilder<OccasionDetailsController>(
        builder: (controller) => Scaffold(
              appBar: _appBarWithTextButton(
                  onTapLeave: () => controller.onTapLeaveOccasion(),
                  acceptStatus: controller.occasionSelected.acceptstatus!),
              floatingActionButton:
                  controller.occasionSelected.acceptstatus != 1
                      ? ConfirmRefuseButtons(onTapConfirm: () {
                          controller.onTapAcceptInvitation();
                        }, onTapRefuse: () {
                          controller.onTapRejectInvitation();
                        })
                      : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'عنوان المناسبة'),
                    const SizedBox(height: 10),
                    DateOrLocationDisplayContainer(
                        hintText: controller.occasionSelected.occasionTitle!,
                        iconData: Icons.date_range,
                        onTap: () {}),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'وقت المناسبة'),
                    DateOrLocationDisplayContainer(
                        hintText: formatDateTime(
                            controller.occasionSelected.occasionDatetime!),
                        iconData: Icons.date_range,
                        onTap: () {}),
                    const SizedBox(height: 10),
                    const CustomSmallBoldTitle(title: 'الموقع'),
                    DateOrLocationDisplayContainer(
                        hintText: 'حدد موقع المناسبة',
                        iconData: Icons.date_range,
                        onTap: () {}),
                    CustomSmallBoldTitle(
                      title: 'المضافين للمناسبة',
                      topPadding: 20,
                      bottomPadding: 20,
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
                                  PersonWithTextListItem(
                                name: controller.members[index].userName!,
                                userName:
                                    controller.members[index].userUsername!,
                                image: controller.members[index].userImage!,
                                endText: controller.displayMemberStatus(index),
                                endTextColor:
                                    controller.displayMemberStatusColor(index),
                                onTapCard: () =>
                                    controller.onTapPersonCard(index),
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

AppBar _appBarWithTextButton(
    {required void Function() onTapLeave, required int acceptStatus}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      'المناسبة',
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
      acceptStatus == 1
          ? TextButton(
              onPressed: onTapLeave,
              child: Text(
                'مغادرة',
                style: titleSmall.copyWith(color: AppColors.redButton),
              ))
          : SizedBox()
    ],
  );
}
