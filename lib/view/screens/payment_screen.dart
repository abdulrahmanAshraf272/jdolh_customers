import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/payment_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/screens/brand_profile/res_service_subscreen.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_button_one_option.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return Scaffold(
      appBar: customAppBar(title: 'الدفع'),
      floatingActionButton: BottomButton(
          onTap: () {
            controller.onTapPay();
          },
          text: 'تأكيد'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          width: Get.width,
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 60),
          child: GetBuilder<PaymentController>(
            builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  IconWithTitleAndSubtitle(
                    svgPath: 'assets/icons/date_time.svg',
                    color: const Color(0xffFFA640),
                    title: 'رسوم الحجز'.tr,
                    subtitle: controller.resPolicyText,
                    price:
                        '${controller.reservation.resResCost!.toStringAsFixed(2)} ريال',
                  ),
                  const SizedBox(height: 20),
                  IconWithTitleAndSubtitle(
                    svgPath: 'assets/icons/bill.svg',
                    color: const Color(0xff00BF63),
                    title: 'قيمة الفاتورة'.tr,
                    subtitle: controller.billPolicyText,
                    price:
                        '${controller.reservation.resBillCost!.toStringAsFixed(2)} ريال',
                  ),
                  SelectPaymentMethod(),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade300,
                  ),
                  const PaymentDetails(),
                ],
              ),
            ),
          )),
    );
  }
}

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text('طريقة الدفع', style: titleMedium),
            CustomToggleButtonsOneOption(
                horizontalDirection: false,
                firstOption: 'دفع بالبطاقة',
                secondOption: 'دفع بالمحفظة',
                onTapOne: () {
                  controller.paymentMethod = 'credit';
                },
                onTapTwo: () {
                  controller.paymentMethod = 'wallet';
                }),
          ],
        ),
      ),
    );
  }
}

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.find();

    return Column(
      children: [
        BillRow(
          title: 'رسوم الحجز'.tr,
          price: controller.reservation.resResCost ?? 0,
        ),
        if (controller.reservation.resPaymentType == 'RB')
          BillRow(
            title: 'قيمة الفاتورة'.tr,
            price: controller.reservation.resBillCost!,
          ),
        BillRow(
          title: 'ضريبة القيمة المضافة'.tr,
          price: controller.tax,
        ),
        // if (controller.reservation.resPaymentType == 'RB')
        //   BillRow(
        //     title: 'الإجمالي'.tr,
        //     price: controller.price,
        //   ),
        BillRow(
          lastRow: true,
          title: 'الإجمالي شامل الضريبة'.tr,
          price: controller.price + controller.tax,
        ),
      ],
    );
  }
}

class IconWithTitleAndSubtitle extends StatelessWidget {
  final String svgPath;
  final Color color;
  final String title;
  final String subtitle;
  final String price;
  const IconWithTitleAndSubtitle({
    super.key,
    required this.svgPath,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.width * 0.23,
          width: Get.width * 0.23,
          padding: EdgeInsets.all(Get.width * 0.06),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: SvgPicture.asset(
            svgPath,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: titleLarge,
        ),
        SizedBox(height: 15),
        AutoSizeText(
          subtitle,
          textAlign: TextAlign.center,
          style: titleSmall,
        ),
        SizedBox(height: 15),
        Text(
          price,
          style: titleLarge,
        ),
        SizedBox(height: 20),
        Divider(
          thickness: 2,
          color: Colors.grey.shade300,
        )
      ],
    );
  }
}
