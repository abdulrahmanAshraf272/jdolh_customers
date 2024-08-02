import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/view/widgets/bills/bill_content_table.dart';
import 'package:zatca_fatoora_flutter/zatca_fatoora_flutter.dart';

class SimpleBill extends StatelessWidget {
  final Bill bill;
  final List<Cart> carts;
  final double taxValue;
  final String taxPercent;
  const SimpleBill(
      {super.key,
      required this.bill,
      required this.carts,
      required this.taxValue,
      required this.taxPercent});

  @override
  Widget build(BuildContext context) {
    final textColor1 = Color(0xFF808080);
    final textColor2 = Color(0xFF5c5c5d);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFf2f2f2),
          border:
              Border.all(width: 1, color: AppColors.black.withOpacity(0.7))),
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
            '${'فاتورة رقم'} ${bill.billId}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 14.sp, color: textColor1),
          ),
          customSpace(),
          Text(
            '${bill.brandName}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16.sp,
                color: textColor2,
                fontWeight: FontWeight.bold),
          ),
          customSpace(),
          Text(
            '${bill.bchLocation}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 12.sp, color: textColor2),
          ),
          customSpace(),
          Row(
            children: [
              Expanded(
                  child: Text(
                      textAlign: TextAlign.start,
                      'تاريخ: ${bill.billCreatetime!.split(' ')[0]}',
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
                      'رقم تسجيل ضريبة القيمة المضافة: ${bill.billVatNo}',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          color: textColor2)))
            ],
          ),
          customSpace(),
          const BillContentTableHeader(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: carts.length,
              itemBuilder: (context, index) => BillContentListItem(
                  productName: carts[index].itemsTitle ?? '',
                  quantity: carts[index].cartQuantity ?? 0,
                  price: carts[index].cartTotalPrice ?? 0,
                  taxPrice: (carts[index].cartTotalPrice! * taxValue),
                  totalPrice: (carts[index].cartTotalPrice! +
                      (carts[index].cartTotalPrice! * taxValue)))),
          customSpace(),
          titleAndValueRow(
              title: 'اجمالي المبلغ الخاضع للضريبة',
              value: '${bill.billAmountWithoutTax}'),
          customSpace(),
          titleAndValueRow(
              title: 'ضريبة القيمة المضافة(${taxPercent}%)',
              value: '${bill.billTaxAmount}'),
          customSpace(),
          if (bill.billDiscount != '0.00')
            titleAndValueRow(
                title: 'خصم رسوم الحجز', value: '${bill.billDiscount}'),
          if (bill.billDiscount != '0.00') customSpace(),
          titleAndValueRow(
              title: 'المجموع مع الضريبة(${taxPercent}%)',
              value: '${bill.billAmount}'),
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
              vatRegistrationNumber: bill.billVatNo!,
              date: DateTime.parse(bill.billCreatetime!),
              totalAmountIncludingVat: double.parse(bill.billAmount!),
            ),
          )
        ],
      ),
    );
  }

  SizedBox customSpace() => const SizedBox(height: 13);
}

class SimpleResBill extends StatelessWidget {
  final Bill bill;
  final double taxValue;
  final String taxPercent;
  const SimpleResBill(
      {super.key,
      required this.bill,
      required this.taxValue,
      required this.taxPercent});

  @override
  Widget build(BuildContext context) {
    final textColor1 = Color(0xFF808080);
    final textColor2 = Color(0xFF5c5c5d);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFf2f2f2),
          border:
              Border.all(width: 1, color: AppColors.black.withOpacity(0.7))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'فاتورة رسوم حجز',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: textColor1),
          ),
          customSpace(),
          Text(
            '${'فاتورة رقم'} ${bill.billId}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 14.sp, color: textColor1),
          ),
          customSpace(),
          Text(
            'جدولة',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16.sp,
                color: textColor2,
                fontWeight: FontWeight.bold),
          ),
          customSpace(),
          Row(
            children: [
              Expanded(
                  child: Text(
                      textAlign: TextAlign.start,
                      'تاريخ: ${bill.billCreatetime!.split(' ')[0]}',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          color: textColor2)))
            ],
          ),
          customSpace(),
          titleAndValueRow(
              title: 'اجمالي المبلغ الخاضع للضريبة',
              value: '${bill.billAmountWithoutTax}'),
          customSpace(),
          titleAndValueRow(
              title: 'ضريبة القيمة المضافة($taxPercent%)',
              value: '${bill.billTaxAmount}'),
          customSpace(),
          titleAndValueRow(
              title: 'المجموع مع الضريبة($taxPercent%)',
              value: '${bill.billAmount}'),
          customSpace(),
          customSpace(),
          Text(
            '<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>',
            style: TextStyle(color: textColor1),
          ),
        ],
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
        Text('$value ريال',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: textColor1))
      ],
    );
  }
}
