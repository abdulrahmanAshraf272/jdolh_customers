import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/desc_branchesButton_workTime.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/header.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/products_sub_screen.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/food.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/extra_fee_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price.dart';
import 'package:jdolh_customers/view/widgets/common/apptDetails/order_content_elements/total_price_with_fee.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_button_one_option.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_dropdown_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_customers/view/widgets/common/flexable_toggle_button.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('brand profile screen rebuild');
    Get.put(BrandProfileController());
    return GetBuilder<BrandProfileController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                title: 'جدولة',
              ),
              floatingActionButton: BottomButton(
                  onTap: () {
                    controller.onTabBottomButton();
                  },
                  text: controller.buttonText),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BrandProfileHeader(),
                    DescAndBranshedButtonAndWorkTime(),
                    LargeToggleButtons(
                        optionOne: 'قائمة الطعام',
                        optionTwo: 'تفاصيل الحجز',
                        onTapOne: () {
                          controller.subScreenSwitch();
                        },
                        onTapTwo: () {
                          controller.subScreenSwitch();
                        }),
                    SizedBox(height: 16),
                    controller.activeSubScreen == 1
                        ? ProductsSubScreen()
                        : ReservationSubScreen()
                  ],
                ),
              ),
            ));
  }
}

// class FollowAndBranshedButtons extends StatelessWidget {
//   const FollowAndBranshedButtons({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomButton(onTap: () {}, text: 'الغاء المتابعة');
//   }
// }




