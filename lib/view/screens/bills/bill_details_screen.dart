import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/bill_details_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:zatca_fatoora_flutter/zatca_fatoora_flutter.dart';

class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor1 = Color(0xFF808080);
    final textColor2 = Color(0xFF5c5c5d);
    final controller = Get.put(BillDetailsController());
    return Scaffold(
      appBar:
          customAppBar(title: '${'فاتورة رقم'.tr} ${controller.bill.billId}'),
      body: GetBuilder<BillDetailsController>(
        builder: (controller) => SingleChildScrollView(
            child: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color(0xFFf2f2f2),
                          border: Border.all(
                              width: 1,
                              color: AppColors.black.withOpacity(0.7))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'فاتورة ضريبية مبسطة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: textColor1),
                          ),
                          customSpace(),
                          Text(
                            '${'فاتورة رقم'} ${controller.bill.billId}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14.sp,
                                color: textColor1),
                          ),
                          customSpace(),
                          Text(
                            '${controller.bill.brandName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.sp,
                                color: textColor2,
                                fontWeight: FontWeight.bold),
                          ),
                          customSpace(),
                          Text(
                            '${controller.bill.bchLocation}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                color: textColor2),
                          ),
                          customSpace(),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      textAlign: TextAlign.start,
                                      'تاريخ: ${controller.bill.billCreatetime!.split(' ')[0]}',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 12.sp,
                                          color: textColor2)))
                            ],
                          ),
                          customSpace(),
                          Row(
                            children: [
                              Expanded(
                                  child: AutoSizeText(
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      'رقم تسجيل ضريبة القيمة المضافة: ${controller.bill.billVatNo}',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 12.sp,
                                          color: textColor2)))
                            ],
                          ),
                          customSpace(),
                          BillContentTableHeader(),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.carts.length,
                              itemBuilder: (context, index) => BillContentListItem(
                                  productName:
                                      controller.carts[index].itemsTitle ?? '',
                                  quantity:
                                      controller.carts[index].cartQuantity ?? 0,
                                  price:
                                      controller.carts[index].cartTotalPrice ??
                                          0,
                                  taxPrice:
                                      (controller.carts[index].cartTotalPrice! *
                                          controller.taxValue),
                                  totalPrice: (controller
                                          .carts[index].cartTotalPrice! +
                                      (controller.carts[index].cartTotalPrice! *
                                          controller.taxValue)))),
                          customSpace(),
                          titleAndValueRow(
                              title: 'اجمالي المبلغ الخاضع للضريبة',
                              value: '${controller.bill.billAmountWithoutTax}'),
                          customSpace(),
                          titleAndValueRow(
                              title:
                                  'ضريبة القيمة المضافة(${controller.taxPercent}%)',
                              value: '${controller.bill.billTaxAmount}'),
                          customSpace(),
                          titleAndValueRow(
                              title:
                                  'المجموع مع الضريبة(${controller.taxPercent}%)',
                              value: '${controller.bill.billAmount}'),
                          customSpace(),
                          customSpace(),
                          Text(
                            '<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>',
                            style: TextStyle(color: textColor1),
                          ),
                          customSpace(),
                          ZatcaFatoora.simpleQRCode(
                            fatooraData: ZatcaFatooraDataModel(
                              businessName: "Business name",
                              vatRegistrationNumber: controller.bill.billVatNo!,
                              date: DateTime.parse(
                                  controller.bill.billCreatetime!),
                              totalAmountIncludingVat:
                                  double.parse(controller.bill.billAmount!),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  SizedBox customSpace() => const SizedBox(height: 13);
}

class titleAndValueRow extends StatelessWidget {
  final String title;
  final String value;
  const titleAndValueRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textColor1 = Color(0xFF808080);
    final textColor2 = Color(0xFF5c5c5d);
    return Row(
      children: [
        Expanded(
            child: AutoSizeText(
                maxLines: 1,
                textAlign: TextAlign.start,
                title,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor2))),
        Text(value,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: textColor1))
      ],
    );
  }
}

class BillContentTableHeader extends StatelessWidget {
  const BillContentTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor1 = const Color(0xFF808080);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'المنتجات',
            style: TextStyle(
                color: textColor1,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'الكمية',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'سعر الوحدة',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'ضريبة القيمة المضافة',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'السعر شامل ضريبة القيمة المضافة',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
      ],
    );
  }
}

class BillContentListItem extends StatelessWidget {
  final String productName;
  final int quantity;
  final double price;
  final double taxPrice;
  final double totalPrice;
  const BillContentListItem({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.taxPrice,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor1 = const Color(0xFF808080);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            productName,
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$quantity',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$price',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$taxPrice',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$totalPrice',
            style: TextStyle(color: textColor1, fontSize: 10.sp),
          ),
        ),
      ],
    );
  }
}
