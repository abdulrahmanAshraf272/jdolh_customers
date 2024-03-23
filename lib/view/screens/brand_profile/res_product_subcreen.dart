import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/res_service_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_product/extra_seats.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_product/oreder_content_list_item.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_customers/view/widgets/number_textfield.dart';

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

    Get.put(BrandProfileController());
    return GetBuilder<BrandProfileController>(
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
                            CustomSmallBoldTitle(title: 'تفضيلات الحجز'),
                            const SizedBox(height: 10),
                            CustomDropdown(
                              horizontalMargin: 0,
                              items: controller.resOptionsTitles,
                              title: controller.initalResOptionTitle,
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
                    hintText: 'اختر وقت و تاريخ الحجز',
                    iconData: Icons.date_range,
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'تفاصيل الطلب',
                  ),
                  HandlingDataRequest(
                    statusRequest: controller.statusRequestCart,
                    widget: controller.carts.isEmpty
                        ? const ListIsEmptyText()
                        : ListView.builder(
                            itemCount: controller.carts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                OrderContentCreationListItem(
                                    image: controller.carts[index].itemsImage,
                                    name: controller.carts[index].itemsTitle ??
                                        '',
                                    desc:
                                        controller.carts[index].cartShortDesc ??
                                            '',
                                    quantity:
                                        controller.carts[index].cartQuantity ??
                                            1,
                                    price: controller
                                        .carts[index].cartTotalPrice
                                        .toString(),
                                    onTapIncrease: () {
                                      controller.onTapIncrease(index);
                                    },
                                    onTapDecrease: () {
                                      controller.onTapDecrease(index);
                                    },
                                    onTapDelete: () {
                                      controller.deleteCart(index);
                                    }),
                          ),
                  ),
                  const SizedBox(height: 20),
                  GoHomeButton(
                    onTap: () {
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
