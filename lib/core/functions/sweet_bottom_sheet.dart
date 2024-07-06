import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sweetsheet/sweetsheet.dart';

sweetBottomSheet(
    {required BuildContext context,
    required String title,
    required String desc,
    required void Function() onTapConfirm,
    void Function()? onTapCancel,
    String? confirmButtonText,
    String? cancelButtonText,
    required CustomSheetColor color,
    required IconData icon}) {
  final SweetSheet sweetSheet = SweetSheet();
  sweetSheet.show(
    isDismissible: false,
    context: context,
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        fontFamily: 'Cairo',
        color: Colors.white,
      ),
    ),
    description: Text(desc,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Cairo',
          fontSize: 13.sp,
          color: Colors.white,
        )),
    color: color,
    icon: icon,
    positive: SweetSheetAction(
      onPressed: onTapConfirm,
      title: confirmButtonText ?? 'نعم'.tr,
    ),
    negative: SweetSheetAction(
      onPressed: onTapCancel ??
          () {
            Navigator.of(context).pop();
          },
      title: cancelButtonText ?? 'الغاء'.tr,
    ),
  );
}
