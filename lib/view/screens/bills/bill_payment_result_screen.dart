import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/bill_payment_result_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/screens/payment_result_screen.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

class BillPaymentResultScreen extends StatelessWidget {
  const BillPaymentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BillPaymentResultController());
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<BillPaymentResultController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.result == 'success'
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Icon(Icons.check_circle_outline,
                                size: 150.h, color: AppColors.secondaryColor)),
                        const SizedBox(height: 10),
                        Text(
                          'تمت عملية الدفع بنجاح',
                          style: titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text('شكراً لاختيارك جدولة'.tr, style: titleMedium),
                        const SizedBox(height: 20),
                        GoHomeButton(onTap: () {
                          Get.offAllNamed(AppRouteName.mainScreen);
                        })
                      ],
                    ),
                  )
                : const Center(child: PaymentFailed())),
      )),
    );
  }
}
