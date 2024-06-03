import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/cart_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_service_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/brand_profile/carts.dart';
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
        title: 'تنبيه'.tr,
        desc: message,
      ).show();
    }

    Get.put(ResServiceConltroller());
    return GetBuilder<ResServiceConltroller>(builder: (controller) {
      return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Column(
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
              CustomSmallBoldTitle(title: 'تفاصيل الحجز'.tr),
              const CartService(),
              const SizedBox(height: 20),
              BillDetails(resCost: controller.resCost),
              const SizedBox(height: 20),
              GoHomeButton(
                onTap: () {
                  var checkResOption = controller
                      .checkAllItemsAvailableWithinResOptionSelected();
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
          ));
    });
  }
}

class BillDetails extends StatelessWidget {
  final double resCost;
  const BillDetails({
    super.key,
    required this.resCost,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Column(
        children: [
          BillRow(
            title: 'المجموع'.tr,
            price: controller.totalPrice,
          ),
          BillRow(
            title: 'رسوم الحجز'.tr,
            price: resCost,
          ),
          BillRow(
            title: 'الإجمالي غير شامل الضريبة'.tr,
            price: controller.totalPrice + resCost,
          ),
          BillRow(
            title: 'ضريبة القيمة المضافة'.tr,
            price: controller.taxCost,
          ),
          BillRow(
            lastRow: true,
            title: 'الإجمالي شامل الضريبة'.tr,
            price: controller.totalPrice + resCost + controller.taxCost,
          ),
        ],
      );
    });
  }
}

class BillRow extends StatelessWidget {
  final String title;
  final num price;
  final bool lastRow;
  const BillRow(
      {super.key,
      required this.title,
      required this.price,
      this.lastRow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                  color:
                      lastRow ? AppColors.secondaryColor300 : AppColors.gray300,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: AutoSizeText(title, maxLines: 1))),
          Expanded(
              flex: 1,
              child: Container(
                  color: lastRow ? AppColors.secondaryColor : AppColors.gray450,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: AutoSizeText(
                    price.toStringAsFixed(2),
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: lastRow ? FontWeight.bold : null,
                        color: lastRow ? Colors.white : Colors.black),
                  ))),
        ],
      ),
    );
  }
}
