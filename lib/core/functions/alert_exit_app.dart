import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void alertExitAppNew() {
  Get.defaultDialog(
      title: 'خروج',
      middleText: 'هل تريد الخروج من التطبيق؟',
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
            SystemNavigator.pop();
          },
          child: const Text('نعم'),
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('الغاء'))
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
