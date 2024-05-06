import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/wait_for_approve_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';

onClickNotificationOnTerminated() async {
  RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    handlingClickedNotification(remoteMessage);
  }
}

onClickNotificatoinOnBackground() {
  FirebaseMessaging.onMessageOpenedApp.listen(handlingClickedNotification);
}

//This function is stream, so it must added in place when the app is just started
//and the scope must be the whole app
handlingNotificationOnForground() {
  FirebaseMessaging.onMessage.listen(handlingReceivedNotificationOnForground);
}

//if received notification when the app in background or closed this function will be called.
handlingNotificationOnBackgroundAndTerminated() {
  FirebaseMessaging.onBackgroundMessage(
      handlingReceivedNotificationOnBackgrundOrTerminated);
}

//===================================================================

Future<void> handlingReceivedNotificationOnForground(
    RemoteMessage remoteMessage) async {
  print(
      '====================== Nortification received in foreground =================');
  if (remoteMessage.notification != null) {
    String title = remoteMessage.notification!.title ?? '';
    String body = remoteMessage.notification!.body ?? '';
    Get.snackbar(title, body, colorText: Colors.white);

    if (remoteMessage.data.isNotEmpty) {
      if (remoteMessage.data['routeName'] == AppRouteName.waitForApprove) {
        if (Get.currentRoute == AppRouteName.waitForApprove) {
          WaitForApproveController controller = Get.find();
          //to Refresh res status
          controller.getRes();
        }
      }
    }
  }
}

Future<void> handlingReceivedNotificationOnBackgrundOrTerminated(
    RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    print(
        '=================== Received Notification in background or terminated ==================');
    // String title = remoteMessage.notification!.title ?? '';
    // String body = remoteMessage.notification!.body ?? '';
  }
}

Future<void> handlingClickedNotification(RemoteMessage remoteMessage) async {
  if (remoteMessage.data.isNotEmpty) {
    String? routeName = remoteMessage.data['routeName'];
    dynamic arg = remoteMessage.data['arg'];
    if (routeName != null) {
      try {
        if (routeName == AppRouteName.waitForApprove) return;

        Get.toNamed(routeName, arguments: arg);
      } catch (e) {
        throw 'error happend when try to go to selected screen ,$e';
      }
    }
  }
}

saveNotificationInLocalDB(String title, String body) {}
