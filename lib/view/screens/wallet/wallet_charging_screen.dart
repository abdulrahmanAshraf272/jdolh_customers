import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/wallet/wallet_charging_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class WalletChargingScreen extends StatefulWidget {
  const WalletChargingScreen({super.key});

  @override
  State<WalletChargingScreen> createState() => _WalletChargingScreenState();
}

class _WalletChargingScreenState extends State<WalletChargingScreen> {
  int selectedPaymentMethod = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletChargingController());
    return Scaffold(
      appBar: customAppBar(title: 'شحن المحفظة'.tr),
      body: SafeArea(
        child: SizedBox(
            width: Get.width,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text('المبلغ'.tr,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  MonoyDepositeTextField(
                    textEditingController: controller.amount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل المبلغ'.tr;
                      }

                      // Check for leading zeros
                      if (value.startsWith('0') &&
                          value.length > 1 &&
                          !value.startsWith('0.')) {
                        return 'رقم غير صالح'.tr;
                      }

                      // Check for valid decimal format
                      if (value.contains(',')) {
                        return 'رقم غير صالح'.tr;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('ريال'),
                  const SizedBox(height: 20),
                  Text(
                    'هذا المبلغ لا يمكن اعادة سحبه يستخدم داخل التطبيق فقط'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  // CustomTitle(
                  //   title: 'طريقة الدفع',
                  //   bottomPadding: 10,
                  // ),
                  // ListView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     scrollDirection: Axis.vertical,
                  //     itemCount: paymentMethodsOptions.length,
                  //     itemBuilder: (context, index) => GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             selectedPaymentMethod = index;
                  //           });
                  //         },
                  //         child: ToggleButtonItem(
                  //           index: index,
                  //           selectedIndex: selectedIndex,
                  //           text: paymentMethodsOptions[index],
                  //           fontSize: 13,
                  //           svgIconPath: paymentMethodsOptionsIcons[index],
                  //         ))),
                  const Spacer(),
                  BottomButton(
                      onTap: () => controller.onTapChargeWallet(),
                      text: 'دفع'.tr)
                ],
              ),
            )),
      ),
    );
  }
}

class MonoyDepositeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  String? Function(String?)? validator;
  MonoyDepositeTextField({
    super.key,
    this.validator,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.2,
      width: Get.width * 0.40,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              validator: validator,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20.sp, color: AppColors.black),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(fontSize: 20.sp, color: Colors.grey),
                // contentPadding: const EdgeInsets.symmetric(
                //     vertical: 5, horizontal: 30),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
