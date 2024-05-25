import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/brand_profile/wait_for_approve_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/notification/notification_data.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    saveNotificationInDB(remoteMessage);

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

    saveNotificationInDB(remoteMessage);
  }
}

Future<void> handlingClickedNotification(RemoteMessage remoteMessage) async {
  if (remoteMessage.data.isNotEmpty) {
    String? routeName = remoteMessage.data['routeName'];
    dynamic objectId = remoteMessage.data['objectId'];
    if (routeName != null) {
      try {
        if (routeName == AppRouteName.waitForApprove) return;

        Get.toNamed(routeName, arguments: objectId);
      } catch (e) {
        throw 'error happend when try to go to selected screen ,$e';
      }
    }
  }
}

saveNotificationInDB(RemoteMessage remoteMessage) async {
  String title = remoteMessage.notification!.title ?? '';
  String body = remoteMessage.notification!.body ?? '';
  String routeName = '';
  String objectId = '-1';
  String image = '';
  String datetime = '';
  if (remoteMessage.data['routeName'] != null) {
    routeName = remoteMessage.data['routeName'];
  }
  if (remoteMessage.data['objectId'] != null) {
    objectId = remoteMessage.data['objectId'].toString();
  }
  if (remoteMessage.data['image'] != null) {
    image = remoteMessage.data['image'];
  }
  if (remoteMessage.data['datetime'] != null) {
    datetime = remoteMessage.data['datetime'];
  }

  print('from handler=======');
  print(remoteMessage.data['routeName']);
  print(remoteMessage.data['objectId']);
  print(remoteMessage.data['image']);
  print(remoteMessage.data['datetime']);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? userid = sharedPreferences.getString('id');
  print('userid ===== ${sharedPreferences.getString('id')}');
  if (userid != null) {
    saveNotification(userid, title, body, image, routeName, objectId, datetime);
  } else {
    print('unable to save notification in database , userid is null');
  }
}
