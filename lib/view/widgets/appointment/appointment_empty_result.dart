import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentEmptyResult extends StatelessWidget {
  final int allDaysCount;
  final int toDayCount;
  const AppointmentEmptyResult(
      {super.key, required this.allDaysCount, required this.toDayCount});

  @override
  Widget build(BuildContext context) {
    return toDayCount == 0 && allDaysCount == 0
        ? Center(child: Text('لا توجد مواعيد قادمة'.tr))
        : toDayCount == 0 && allDaysCount != 0
            ? Center(child: Text('لا توجد مواعيد في هذا اليوم'.tr))
            : const SizedBox();
  }
}
