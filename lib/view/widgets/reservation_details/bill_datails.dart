import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class BillDetails extends StatelessWidget {
  final Reservation reservation;
  const BillDetails({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BillRow(
          title: 'المجموع'.tr,
          price: reservation.resBillCost ?? 0,
        ),
        BillRow(
          title: 'رسوم الحجز'.tr,
          price: reservation.resResCost ?? 0,
        ),
        BillRow(
          title: 'الإجمالي غير شامل الضريبة'.tr,
          price: reservation.resBillCost! + reservation.resResCost!,
        ),
        BillRow(
          title: 'ضريبة القيمة المضافة'.tr,
          price: reservation.resBillTax! + reservation.resResTax!,
        ),
        BillRow(
          lastRow: true,
          title: 'الإجمالي شامل الضريبة'.tr,
          price: reservation.resTotalPrice ?? 0,
        ),
        if (reservation.resResPolicy == 1 && reservation.resBillPayed == 1)
          BillRow(
            lastRow: true,
            title: 'بعد خصم رسوم الحجز'.tr,
            price: reservation.resTotalPrice! - reservation.resResCost!,
          ),
      ],
    );
  }
}

class BillRow extends StatelessWidget {
  final String title;
  final num price;
  final bool lastRow;
  const BillRow(
      {super.key,
      required this.title,
      required this.price,
      this.lastRow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                  color:
                      lastRow ? AppColors.secondaryColor300 : AppColors.gray300,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: AutoSizeText(title, maxLines: 1))),
          Expanded(
              flex: 1,
              child: Container(
                  color: lastRow ? AppColors.secondaryColor : AppColors.gray450,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: AutoSizeText(
                    price.toStringAsFixed(2),
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: lastRow ? FontWeight.bold : null,
                        color: lastRow ? Colors.white : Colors.black),
                  ))),
        ],
      ),
    );
  }
}
