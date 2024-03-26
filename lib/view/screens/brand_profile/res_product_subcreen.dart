import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_product_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/carts.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/invintors.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_product/extra_seats.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_product/oreder_content_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class ResProductSubscreen extends StatelessWidget {
  const ResProductSubscreen({super.key});

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

    Get.put(ResProductController());
    return GetBuilder<ResProductController>(
        builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            const CustomSmallBoldTitle(title: 'تفضيلات الحجز'),
                            const SizedBox(height: 10),
                            CustomDropdown(
                              horizontalMargin: 0,
                              items: controller.resOptionsTitles,
                              title:
                                  controller.selectedResOption.resoptionsTitle!,
                              displacement: 0,
                              onChanged: (String? value) {
                                controller.selectResOption(value!);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: ExtraSeats(
                              textEditingController: controller.extraSeats)),
                      const SizedBox(width: 20)
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
                  const Invitors(),
                  const SizedBox(height: 15),
                  const CustomSmallBoldTitle(
                    title: 'تفاصيل الطلب',
                  ),
                  const CartProduct(),
                  const SizedBox(height: 20),
                  GoHomeButton(
                    onTap: () {
                      print('${controller.selectedResOption.resoptionsTitle}');
                      var checkResOption = controller
                          .checkAllItemsAvailableWithinResOptionSelected();
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
            ));
  }
}
