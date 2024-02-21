import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/functions/get_current_position.dart';

onDoneOperation(BuildContext context, String title, Function()? onPressOk,
    Function(DismissType dismissType)? onDismissed, String btnOkText) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    title: title,
    btnOkText: btnOkText,
    //desc: 'Dialog description here.............',
    // btnCancelOnPress: () {},
    //After i press ok , will go back the main screen.
    btnOkOnPress: onPressOk,
    onDismissCallback: onDismissed,
  ).show();
}

activePermissionAlert() {
  Get.defaultDialog(
      title: "تحذير",
      middleText: "يجب عليك تفعيل اماكنية الوصول للموقع لتتمكن من تسجيل الوصول",
      textConfirm: 'حسنا',
      onConfirm: () {
        getCurrentPosition();
        Get.back();
      });
}

activeGpsAlert() {
  Get.defaultDialog(
      title: "الGPS غير مفعل",
      middleText: 'من فضلك فعل الGPS ثم اضغط تم',
      textConfirm: 'تم',
      onConfirm: () {},
      textCancel: "الغاء",
      onCancel: () => getCurrentPosition());
}
