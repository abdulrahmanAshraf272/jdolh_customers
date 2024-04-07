import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/payment_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/flexable_toggle_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedIndex = 0;
  List<String> list = [
    'سداد القيمة كاملة 161 ريال و خصم الحجز 131 ريال',
    'سداد رسوم الحجز فقط 30 ريال'
  ];
  int selectedPaymentMethod = 0;
  List<String> paymentMethodsOptions = [
    'الدفع كاش',
    'الدفع بالبطاقة',
    'تابي',
    'قسطها على تمارا',
    'ds'
  ];
  List<String> paymentMethodsOptionsIcons = [
    'assets/icons/bill.svg',
    'assets/icons/bill.svg',
    'assets/icons/bill.svg',
    'assets/icons/bill.svg',
    'assets/icons/bill.svg'
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return Scaffold(
      appBar: customAppBar(title: 'الدفع'),
      floatingActionButton: BottomButton(
          onTap: () {
            controller.onTapConfirm();
          },
          text: 'تأكيد'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          width: Get.width,
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 60),
          child: GetBuilder<PaymentController>(
            builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                child: Column(
                  children: [
                    IconWithTitleAndSubtitle(
                      svgPath: 'assets/icons/date_time.svg',
                      color: const Color(0xffFFA640),
                      title: 'رسوم الحجز',
                      subtitle: controller.resPolicy,
                      price: '${controller.resCost.toStringAsFixed(2)} ريال',
                    ),
                    const SizedBox(height: 20),
                    IconWithTitleAndSubtitle(
                      svgPath: 'assets/icons/bill.svg',
                      color: const Color(0xff00BF63),
                      title: 'قيمة الفاتورة',
                      subtitle: controller.billPolicy,
                      price: '${controller.billCost.toStringAsFixed(2)} ريال',
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: list.length,
                        itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: ToggleButtonItem(
                              index: index,
                              selectedIndex: selectedIndex,
                              text: list[index],
                              fontSize: 13,
                            ))),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                  ],
                ),
              ),
            ),
          )),
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
