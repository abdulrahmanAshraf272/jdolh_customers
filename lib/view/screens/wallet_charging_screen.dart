import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/flexable_toggle_button.dart';

class WalletChargingScreen extends StatefulWidget {
  const WalletChargingScreen({super.key});

  @override
  State<WalletChargingScreen> createState() => _WalletChargingScreenState();
}

class _WalletChargingScreenState extends State<WalletChargingScreen> {
  int selectedPaymentMethod = 0;
  int selectedIndex = 0;
  List<String> paymentMethodsOptions = [
    'الدفع كاش',
    'الدفع بالبطاقة',
    'تابي',
    'قسطها على تمارا',
  ];
  List<String> paymentMethodsOptionsIcons = [
    'assets/icons/bill.svg',
    'assets/icons/bill.svg',
    'assets/icons/bill.svg',
    'assets/icons/bill.svg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'المحفظة'),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text('المبلغ',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              MonoyDepositeTextField(
                textEditingController: TextEditingController(),
              ),
              SizedBox(height: 40),
              CustomTitle(
                title: 'طريقة الدفع',
                bottomPadding: 10,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.vertical,
                  itemCount: paymentMethodsOptions.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = index;
                        });
                      },
                      child: ToggleButtonItem(
                        index: index,
                        selectedIndex: selectedIndex,
                        text: paymentMethodsOptions[index],
                        fontSize: 13,
                        svgIconPath: paymentMethodsOptionsIcons[index],
                      ))),
              Spacer(),
              BottomButton(onTap: () {}, text: 'دفع')
            ],
          ),
        ),
      ),
    );
  }
}

class MonoyDepositeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const MonoyDepositeTextField({
    super.key,
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
