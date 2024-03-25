import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
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
    Get.put(BrandProfileController());
    return GetBuilder<BrandProfileController>(
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
                          SizedBox(width: 20),
                          AutoSizeText(
                            'المضافين للدعوة',
                            maxLines: 1,
                            style: titleMedium,
                          ),
                          Spacer(),
                          CustomButton(onTap: () {}, text: '+ أضف للدعوة'),
                          SizedBox(width: 20),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemCount: 1,
                          itemBuilder: (context, index) =>
                              PersonWithToggleListItem()),
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
