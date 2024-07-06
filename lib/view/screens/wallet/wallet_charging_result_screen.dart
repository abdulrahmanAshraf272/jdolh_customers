import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/wallet/wallet_charging_result_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/screens/payment_result_screen.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

class WalletChargingResultScreen extends StatelessWidget {
  const WalletChargingResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletChargingResultController());
    return Scaffold(
      body: GetBuilder<WalletChargingResultController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SafeArea(
                  child: controller.newBalance != ''
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Icon(Icons.check_circle_outline,
                                      size: 150.h,
                                      color: AppColors.secondaryColor)),
                              const SizedBox(height: 10),
                              Text(
                                '${'تهانينا, تم شحن مبلغ'.tr} ${controller.amount} ريال',
                                style: titleLarge,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${'رصيدك الان'.tr} ${controller.newBalance} ${'ريال'.tr}',
                                style: headline4,
                              ),
                              const SizedBox(height: 10),
                              Text('شكراً لاختيارك جدولة'.tr,
                                  style: titleMedium),
                              const SizedBox(height: 20),
                              GoHomeButton(onTap: () {
                                Get.offAllNamed(AppRouteName.mainScreen);
                              })
                            ],
                          ),
                        )
                      : Center(child: const PaymentFailed())))),
    );
  }
}
