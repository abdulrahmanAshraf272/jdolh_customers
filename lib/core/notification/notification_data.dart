import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'dart:convert';
import 'package:jdolh_customers/core/notification/notification_const.dart';
import 'package:jdolh_customers/data/data_source/remote/notification.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:jdolh_customers/data/data_source/remote/server_key.dart';

Future getServiceAccountJson(ReceiverApp receiverApp) async {
  Map<String, String> serviceAccountJson;
  ServerKeyData serverKeyData = ServerKeyData(Get.find());
  var response = await serverKeyData.getServerKey();
  StatusRequest statusRequest = handlingData(response);
  if (statusRequest == StatusRequest.success) {
    if (response['status'] == 'success') {
      if (receiverApp == ReceiverApp.customer) {
        serviceAccountJson =
            Map<String, String>.from(response['customersServerAccountNew']);
      } else if (receiverApp == ReceiverApp.brand) {
        serviceAccountJson =
            Map<String, String>.from(response['brandServerAccountNew']);
      } else {
        serviceAccountJson =
            Map<String, String>.from(response['adminServerAccountNew']);
      }

      print('serviceAccountJson = $serviceAccountJson');
      return serviceAccountJson;
    } else {
      print('failed to get service account json');
    }
  } else {
    print('get service account status: $statusRequest');
  }
}

Future<void> sendNotification({
  required String topic,
  required String title,
  required String body,
  required ReceiverApp receiverApp,
  Map<String, dynamic>? data,
}) async {
  String projectId;

  // Assigning the projectId and serviceAccountJson based on the receiverApp
  if (receiverApp == ReceiverApp.customer) {
    projectId = CUSTOMERS_PROJECT_ID;
  } else if (receiverApp == ReceiverApp.brand) {
    projectId = BRAND_PROJECT_ID;
  } else {
    projectId = ADMIN_PROJECT_ID;
  }

  Map<String, String>? serviceAccountJson =
      await getServiceAccountJson(receiverApp);

  if (serviceAccountJson == null) {
    return;
  }

  // Get the Bearer token
  var serverKeyAuthorization = await getAccessToken(serviceAccountJson);

  // FCM v1 server endpoint
  String url =
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

  // Ensure that data is a Map<String, String>
  final Map<String, String> stringData = {};
  if (data != null && data.isNotEmpty) {
    data.forEach((key, value) {
      stringData[key] = value.toString(); // Ensure every value is a string
    });
  }

  // Data for the FCM message
  final Map<String, dynamic> payload = {
    "message": {
      "topic": topic, // Sending to a topic
      "notification": {
        "title": title,
        "body": body,
      },
      // Optional data payload
      if (stringData.isNotEmpty) "data": stringData,
    }
  };

  // Encode the payload to JSON
  final String jsonPayload = jsonEncode(payload);

  // HTTP headers
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer $serverKeyAuthorization', // Use Bearer token from getAccessToken
  };

  try {
    // Send the POST request to FCM server
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonPayload,
    );

    // Log response for debugging
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');

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

Future<String?> getAccessToken(Map<String, String> serviceAccountJson) async {
  List<String> scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/firebase.database",
    "https://www.googleapis.com/auth/firebase.messaging"
  ];

  try {
    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();
    print(
        "Access Token: ${credentials.accessToken.data}"); // Print Access Token
    return credentials.accessToken.data;
  } catch (e) {
    print("Error getting access token: $e");
    return null;
  }
}

// Future<void> sendNotification({
//   required String topic,
//   required String title,
//   required body,
//   required ReceiverApp receiverApp,
//   Map<String, dynamic>? data,
// }) async {
//   // FCM server endpoint
//   const String url = 'https://fcm.googleapis.com/fcm/send';

//   // Data for the notification
//   final Map<String, dynamic> payload = {
//     'notification': {
//       'title': title,
//       'body': body,
//     },
//     'to': '/topics/$topic', // Sending to a topic
//   };

//   // Add optional data payload if provided
//   if (data != null && data.isNotEmpty) {
//     payload['data'] = data;
//   }

//   // Encode the payload to JSON
//   final String jsonPayload = jsonEncode(payload);

//   String serverKey;
//   if (receiverApp == ReceiverApp.customer) {
//     serverKey = CUSTOMERS_SERVER_KEY;
//   } else if (receiverApp == ReceiverApp.brand) {
//     serverKey = BRANDS_SERVER_KEY;
//   } else {
//     serverKey = ADMIN_SERVER_KEY;
//   }

//   // HTTP headers
//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'key=$serverKey',
//   };

//   try {
//     // Send the POST request to FCM server
//     final http.Response response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonPayload,
//     );

//     // Check the response
//     if (response.statusCode == 200) {
//       print('Notification sent successfully');
//     } else {
//       print('Failed to send notification. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error sending notification: $e');
//   }
// }

Future saveNotification(String userid, String title, String body, String image,
    String route, String objectid, String datetime) async {
  NotificationData notificationData = NotificationData();
  StatusRequest statusRequest = StatusRequest.none;

  print('from saveNotification =======');
  print(route);
  print(objectid);
  print(image);
  print(datetime);

  var response = await notificationData.createNotification(
      userid: userid,
      title: title,
      body: body,
      image: image,
      route: route,
      objectid: objectid,
      datetime: datetime);
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
