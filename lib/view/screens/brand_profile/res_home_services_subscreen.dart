import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_home_services_controller.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_service_subscreen.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/carts.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/reservation_sub_screen/res_service/service_duration.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_dropdown.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class ResHomeServicesSubscreen extends StatelessWidget {
  const ResHomeServicesSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    warningDialog(String message) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'تنبيه'.tr,
        desc: message,
      ).show();
    }

    Get.put(ResHomeServicesController());
    return GetBuilder<ResHomeServicesController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomSmallBoldTitle(title: 'تفضيلات الحجز'.tr),
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
                const ServiceDuration()
              ],
            ),
            const SizedBox(height: 20),
            CustomSmallBoldTitle(title: 'وقت الحجز'.tr),
            const SizedBox(height: 10),
            DateOrLocationDisplayContainer(
              verticalMargin: 0,
              hintText: controller.selectedResDateTime != ''
                  ? controller.selectedResDateTime
                  : 'اختر وقت و تاريخ الحجز'.tr,
              iconData: Icons.date_range,
              onTap: () => controller.gotoSetResTime(),
            ),
            const SizedBox(height: 20),
            CustomSmallBoldTitle(title: 'الموقع'.tr),
            DateOrLocationDisplayContainer(
                hintText: controller.myLocation != ''
                    ? controller.myLocation
                    : 'حدد موقع المنزل'.tr,
                iconData: Icons.place,
                onTap: () {
                  controller.goToAddLocation();
                }),
            CustomSmallBoldTitle(title: 'العنوان'.tr),
            const SizedBox(height: 10),
            CustomTextField(
                textEditingController: controller.hood,
                labelText: 'اسم الحي'.tr),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: controller.street,
                labelText: 'اسم الشارع'.tr),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: controller.building,
                labelText: 'اسم البرج'.tr),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: controller.floor,
                textInputType: TextInputType.number,
                labelText: 'رقم الدور'.tr),
            const SizedBox(height: 15),
            CustomTextField(
                textEditingController: controller.apartment,
                textInputType: TextInputType.number,
                labelText: 'رقم الشقة'.tr),
            const SizedBox(height: 20),
            CustomSmallBoldTitle(title: 'تفاصيل الحجز'.tr),
            const CartService(),
            const SizedBox(height: 20),
            BillDetails(
              resCost: controller.resCost,
            ),
            const SizedBox(height: 20),
            GoHomeButton(
              onTap: () {
                var checkResOption =
                    controller.checkAllItemsAvailableWithinResOptionSelected();
                if (checkResOption != true) {
                  warningDialog(checkResOption);
                  return;
                }
                controller.onTapConfirmRes();
              },
              text: 'تأكيد الحجز'.tr,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
