import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/bill_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/bills/simple_bill.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/two_options_large_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BillDetailsController());
    return Scaffold(
      appBar:
          customAppBar(title: '${'فاتورة رقم'.tr} ${controller.bill.billId}'),
      bottomNavigationBar: controller.bill.isOriginal == 1 &&
              controller.bill.billPaymentMethod == ''
          ? TwoOptionLargeButtons(
              firstOption: 'دفع',
              onTapFirst: () => controller.onTapPay(),
              secondOption: 'تقسيم الفاتورة',
              onTapSecond: () => controller.onTapDivideBill())
          : controller.bill.isOriginal == 0 &&
                  controller.bill.billPaymentMethod == ''
              ? BottomButton(onTap: () => controller.onTapPay(), text: 'دفع')
              : null,
      body: GetBuilder<BillDetailsController>(
        builder: (controller) => SingleChildScrollView(
            child: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    if (controller.paymentMethod != '')
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text('طريقة الدفع: ${controller.paymentMethod}',
                            style: titleMedium, textAlign: TextAlign.center),
                      ),
                    if (controller.bill.isOriginal == 0)
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'تم تقسيم الفاتورة الاصلية المبلغ الذي عليك دفعه هو:'
                                  .tr,
                              style: titleMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.center,
                              '${controller.bill.billAmount} ريال',
                              style: titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                                textAlign: TextAlign.center,
                                'شامل ضريبة القيمة المضافة'.tr,
                                style: titleSmall),
                            const SizedBox(height: 25),
                            if (controller.originalBill == null)
                              TextButton(
                                  onPressed: () =>
                                      controller.displayOriginalBill(),
                                  child: Text(
                                    'عرض الفاتورة؟'.tr,
                                    style: const TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 12),
                                  ))
                          ],
                        ),
                      ),
                    if (controller.bill.isOriginal == 1 ||
                        controller.originalBill != null)
                      //if it is original bill display it
                      //if it is not original and the customer want to display the origina bill display it
                      controller.bill.billType == 'B'
                          ? SimpleBill(
                              bill: controller.originalBill ?? controller.bill,
                              carts: controller.carts,
                              taxValue: controller.taxValue,
                              taxPercent: controller.taxPercent)
                          : SimpleResBill(
                              bill: controller.originalBill ?? controller.bill,
                              taxValue: controller.taxValue,
                              taxPercent: controller.taxPercent)
                  ],
                ))),
      ),
    );
  }
}
