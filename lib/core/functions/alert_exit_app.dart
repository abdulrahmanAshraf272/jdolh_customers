import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
