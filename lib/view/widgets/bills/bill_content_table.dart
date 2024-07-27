import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
