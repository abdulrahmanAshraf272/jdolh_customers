import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'dart:convert';
import 'package:jdolh_customers/core/notification/notification_const.dart';
import 'package:jdolh_customers/data/data_source/remote/notification.dart';

Future<void> sendNotification({
  required String topic,
  required String title,
  required body,
  required ReceiverApp receiverApp,
  Map<String, dynamic>? data,
}) async {
  // FCM server endpoint
  const String url = 'https://fcm.googleapis.com/fcm/send';

  // Data for the notification
  final Map<String, dynamic> payload = {
    'notification': {
      'title': title,
      'body': body,
    },
    'to': '/topics/$topic', // Sending to a topic
  };

  // Add optional data payload if provided
  if (data != null && data.isNotEmpty) {
    payload['data'] = data;
  }

  // Encode the payload to JSON
  final String jsonPayload = jsonEncode(payload);

  String serverKey;
  if (receiverApp == ReceiverApp.customer) {
    serverKey = CUSTOMERS_SERVER_KEY;
  } else if (receiverApp == ReceiverApp.brand) {
    serverKey = BRANDS_SERVER_KEY;
  } else {
    serverKey = ADMIN_SERVER_KEY;
  }

  // HTTP headers
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  try {
    // Send the POST request to FCM server
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonPayload,
    );

    // Check the response
    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}

Future saveNotificationInDB(int userid, String title, String body, String image,
    String route, int objectid) async {
  NotificationData notificationData = NotificationData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  var response = await notificationData.createNotification(
      userid: userid.toString(),
      title: title,
      body: body,
      image: image,
      route: route,
      objectid: objectid.toString());
  statusRequest = handlingData(response);
  print('save notification status $statusRequest');
  if (statusRequest == StatusRequest.success) {
    if (response['status'] == 'success') {
      print('save notification in database is done successfuly!');
    } else {
      print('save notification failed');
    }
  }
}

////// =-=-=-=-=--=-=-=--=-=-=////
Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
