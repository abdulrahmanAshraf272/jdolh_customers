import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void alertExitAppNew() {
  Get.defaultDialog(
      title: 'خروج'.tr,
      middleText: 'هل تريد الخروج من التطبيق؟'.tr,
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
            SystemNavigator.pop();
          },
          child: Text('نعم'.tr),
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('الغاء'.tr))
      ]);
}

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: 'alert',
      middleText: 'do you want to exit app',
      actions: [
        ElevatedButton(
          onPressed: () {
            exit(0);
          },
          child: const Text('yes'),
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('cancel'))
      ]);
  return Future.value(true);
}
