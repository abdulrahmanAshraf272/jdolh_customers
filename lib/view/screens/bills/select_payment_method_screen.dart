import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/select_payment_method_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
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
      bottomNavigationBar:
          BottomButton(onTap: () => controller.onTapPay(), text: 'دفع'.tr),
      body: GetBuilder<SelectPaymentMethodController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTitle(title: 'طريقة الدفع'.tr),
                  const SizedBox(height: 10),
                  PaymentMethodsToggle(
                    customerWalletBalance: controller.customerWalletBalance,
                    onTapCash: controller.cashEligible
                        ? () => controller.selectedMethod = 'cash'
                        : null,
                    onTapCredit: controller.creditEligible
                        ? () => controller.selectedMethod = 'credit'
                        : null,
                    onTapWallet: controller.creditEligible
                        ? () => controller.selectedMethod = 'wallet'
                        : null,
                    onTapTamara: controller.tamaraEligible
                        ? () => controller.selectedMethod = 'tamara'
                        : null,
                    onTapTabby: controller.tabbyEligible
                        ? () => controller.selectedMethod = 'tabby'
                        : null,
                  )
                ],
              ))),
    );
  }
}

class PaymentMethodsToggle extends StatefulWidget {
  final void Function()? onTapCash;
  final void Function()? onTapCredit;
  final void Function()? onTapWallet;
  final void Function()? onTapTamara;
  final void Function()? onTapTabby;
  final String customerWalletBalance;

  const PaymentMethodsToggle(
      {super.key,
      this.onTapCash,
      this.onTapCredit,
      this.onTapWallet,
      this.onTapTamara,
      this.onTapTabby,
      required this.customerWalletBalance});

  @override
  State<PaymentMethodsToggle> createState() => _PaymentMethodsToggleState();
}

class _PaymentMethodsToggleState extends State<PaymentMethodsToggle> {
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          if (widget.onTapCash != null)
            option(1, 'الدفع في الفرع'.tr, widget.onTapCash!,
                'assets/icons/cash.png'),
          if (widget.onTapCredit != null)
            option(2, 'الدفع بالبطاقة'.tr, widget.onTapCredit!,
                'assets/icons/credit.png'),
          if (widget.onTapWallet != null)
            option(3, 'الدفع بالمحفظة'.tr, widget.onTapWallet!,
                'assets/icons/wallet.png'),
          if (widget.onTapWallet != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('رصيدك: ${widget.customerWalletBalance} ريال',
                  style: titleSmall.copyWith(
                    color: Colors.green,
                  )),
            ),
          if (widget.onTapTamara != null)
            option(4, 'قسطها على تمارا'.tr, widget.onTapTamara!,
                'assets/icons/tamara.png'),
          if (widget.onTapTabby != null)
            option(5, 'قسطها على تابي'.tr, widget.onTapTabby!,
                'assets/icons/tabby.png'),
        ],
      ),
    );
  }

  Container option(
      int optionNumber, String txt, void Function() function, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = optionNumber;
            function();
            print(selectedOption);
          });
        },
        child: Row(
          children: [
            Container(
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
        ),
      ),
    );
  }
}
