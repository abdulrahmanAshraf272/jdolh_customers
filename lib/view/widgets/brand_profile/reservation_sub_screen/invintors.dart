import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_product_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/small_toggle_buttons.dart';

class Invitors extends StatelessWidget {
  const Invitors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ResProductController());
    return GetBuilder<ResProductController>(
        builder: (controller) => Column(
              children: [
                SmallToggleButtons(
                  optionOne: 'بدون دعوة',
                  optionTwo: 'ارسال دعوة',
                  onTapOne: () => controller.switchWithInvitors(false),
                  onTapTwo: () => controller.switchWithInvitors(true),
                ),
                const SizedBox(height: 15),
                if (controller.withInvitros)
                  Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          AutoSizeText(
                            'المضافين للدعوة',
                            maxLines: 1,
                            style: titleMedium,
                          ),
                          const Spacer(),
                          CustomButton(
                              onTap: () => controller.onTapAddMembers(),
                              text: '+ أضف للدعوة'),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 15),
                      controller.members.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 70),
                              shrinkWrap: true,
                              itemCount: controller.members.length,
                              itemBuilder: (context, index) =>
                                  PersonWithToggleListItem(
                                name: controller.members[index].userName!,
                                image: controller.members[index].userImage!,
                                onTapRemove: () =>
                                    controller.removeMember(index),
                              ),
                              // Add separatorBuilder
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'لا يوجد مدعوين!\n',
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
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 2,
                      ),
                    ],
                  )
              ],
            ));
  }
}
