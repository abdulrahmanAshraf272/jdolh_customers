import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_service_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/carts.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_product/oreder_content_list_item.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_service/cart_list_item.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_service/service_duration.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class ResServiceSubscreen extends StatelessWidget {
  const ResServiceSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    warningDialog(String message) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'تنبيه',
        desc: message,
      ).show();
    }

    Get.put(ResServiceConltroller());
    return GetBuilder<ResServiceConltroller>(builder: (controller) {
      print('shit');
      controller.calcResTotalDuration();
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomSmallBoldTitle(title: 'تفضيلات الحجز'),
                      const SizedBox(height: 10),
                      CustomDropdown(
                        items: controller.resOptionsTitles,
                        title: controller.selectedResOption.resoptionsTitle!,
                        displacement: 0,
                        onChanged: (String? value) {
                          controller.selectResOption(value!);
                        },
                      ),
                    ],
                  ),
                ),
                ServiceDuration(duration: controller.totalServiceDuration)
              ],
            ),
            const SizedBox(height: 20),
            const CustomSmallBoldTitle(title: 'وقت الحجز'),
            const SizedBox(height: 10),
            DateOrLocationDisplayContainer(
              verticalMargin: 0,
              hintText: controller.selectedResDateTime != ''
                  ? controller.selectedResDateTime
                  : 'اختر وقت و تاريخ الحجز',
              iconData: Icons.date_range,
              onTap: () => controller.gotoSetResTime(),
            ),
            const SizedBox(height: 20),
            const CustomSmallBoldTitle(
              title: 'تفاصيل الحجز',
            ),
            const CartService(),
            const SizedBox(height: 20),
            GoHomeButton(
              onTap: () {
                var checkResOption =
                    controller.checkAllItemsAvailableWithinResOptionSelected();
                if (checkResOption != true) {
                  warningDialog(checkResOption);
                  return;
                }
                controller.onTapConfirmReservation();
              },
              text: 'تأكيد الحجز',
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
