import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/select_payment_method_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectPaymentMethodController());
    return Scaffold(
      appBar:
          customAppBar(title: '${'فاتورة رقم'.tr} ${controller.bill.billId}'),
      bottomNavigationBar: BottomButton(onTap: () {}, text: 'دفع'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CustomTitle(title: 'طريقة الدفع'),
          const SizedBox(height: 10),
          PaymentMethodsToggle(
              onTapCash: () => controller.selectedMethod = 'cash',
              onTapCredit: () => controller.selectedMethod = 'credit',
              onTapWallet: () => controller.selectedMethod = 'wallet',
              onTapTamara: () => controller.selectedMethod = 'tamara')
        ],
      ),
    );
  }
}

class PaymentMethodsToggle extends StatefulWidget {
  final void Function() onTapCash;
  final void Function() onTapCredit;
  final void Function() onTapWallet;
  final void Function() onTapTamara;

  const PaymentMethodsToggle({
    super.key,
    required this.onTapCash,
    required this.onTapCredit,
    required this.onTapWallet,
    required this.onTapTamara,
  });

  @override
  State<PaymentMethodsToggle> createState() => _PaymentMethodsToggleState();
}

class _PaymentMethodsToggleState extends State<PaymentMethodsToggle> {
  int selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          option(
              1, 'الدفع في الفرع', widget.onTapCash, 'assets/icons/cash.png'),
          const SizedBox(height: 10),
          option(2, 'الدفع بالبطاقة', widget.onTapCredit,
              'assets/icons/credit.png'),
          const SizedBox(height: 10),
          option(3, 'الدفع بالمحفظة', widget.onTapWallet,
              'assets/icons/wallet.png'),
          const SizedBox(height: 10),
          option(4, 'قسطها على تمارا', widget.onTapTamara,
              'assets/icons/tamara.png'),
        ],
      ),
    );
  }

  Row option(
      int optionNumber, String txt, void Function() function, String image) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = optionNumber;
              function();
              print(selectedOption);
            });
          },
          child: Container(
            height: 16,
            width: 16,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                shape: BoxShape.circle,
                color: const Color(0xffF3F3F3)),
            child: Center(
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedOption == optionNumber
                        ? AppColors.secondaryColor
                        : null),
              ),
            ),
          ),
        ),
        Image.asset(
          image,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 10),
        Text(txt,
            style: titleSmall.copyWith(
              color: AppColors.grayText,
            )),
      ],
    );
  }
}
