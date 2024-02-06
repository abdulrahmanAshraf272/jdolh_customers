import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: customAppBar(title: 'الفواتير'),
      floatingActionButton: BottomButton(onTap: () {}, text: 'تأكيد'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconWithTitleAndSubtitle(
                svgPath: 'assets/icons/date_time.svg',
                color: Color(0xffFFA640),
                title: 'رسوم الحجز',
                subtitle:
                    'رسوم الحجز تخصم من الفاتورة و غير مستردة في حال الإلغاء',
                price: '30 ريال',
              ),
              SizedBox(height: 20),
              IconWithTitleAndSubtitle(
                svgPath: 'assets/icons/bill.svg',
                color: Color(0xff00BF63),
                title: 'قيمة الفاتورة',
                subtitle: 'قيمة الفاتورة يمكن دفعها عند الوصول وتعديل الطلب',
                price: '161 ريال',
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
          '30 ريال',
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
