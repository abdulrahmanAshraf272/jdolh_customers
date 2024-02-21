import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/checkin/checkin_confirm_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/view/screens/checkin/checkin_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class CheckinConfirmScreen extends StatelessWidget {
  const CheckinConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckinConfirmController());
    return GetBuilder<CheckinConfirmController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'تسجيل وصول'),
              floatingActionButton: BottomButton(
                onTap: () => controller.checkin(context),
                text: 'تأكيد',
                buttonColor: AppColors.secondaryColor,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    PlacesListItem(
                        name: controller.placeSelected.name ?? '',
                        location: controller.placeSelected.location ?? '',
                        type: controller.placeSelected.type ?? '',
                        onTapCard: () {}),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.comment,
                        hintText: 'ما هو رأيك في المكان؟'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomSmallBoldTitle(
                              title: 'اضافة اصدقاء',
                              topPadding: 20,
                              bottomPadding: 20,
                            ),
                          ),
                          CustomButton(
                              onTap: () {
                                controller.onTapAddMembers();
                              },
                              text: 'أضافة'),
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
                            padding: const EdgeInsets.only(top: 30),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'اذا كنت مع اصدقائك\n',
                                    style: TextStyle(
                                        color: AppColors.black.withOpacity(0.7),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo'),
                                  ),
                                  TextSpan(
                                      text: 'يمنك تسجيل الوصول لهم ايضا',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
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
