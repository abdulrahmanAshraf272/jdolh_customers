import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/notification/notification_const.dart';
import 'package:jdolh_customers/core/notification/notification_data.dart';
import 'package:jdolh_customers/core/services/services.dart';

abstract class NotificationSender {
  MyServices myServices = Get.find();

  static sendFollowingPerson(
      int? userId, int myId, String myName, String myImage) {
    if (userId == null) return;
    sendToCustomer(
        userid: userId,
        title: 'قام $myName بمتابعتك',
        body: 'قام $myName بمتابعتك على تطبيق جدولة',
        image: myImage,
        route: AppRouteName.personProfile,
        objectid: myId,
        data: {"routeName": AppRouteName.personProfile, "arg": myId});
  }

  static sendToCustomer(
      {required int userid,
      required String title,
      required String body,
      required String image,
      Map<String, dynamic>? data,
      String? route,
      int? objectid}) {
    sendNotification(
        topic: '$userSubscribe-$userid',
        title: title,
        body: body,
        receiverApp: ReceiverApp.customer,
        data: data);
    saveNotificationInDB(userid, title, body,
        '${ApiLinks.customerImage}/$image', route ?? '', objectid ?? 0);
  }

  static sendToBch(
      {required int bchid,
      required String title,
      required String body,
      Map<String, dynamic>? data,
      String? route,
      int? objectid}) {
    sendNotification(
        topic: '$bchSubscribe-$bchid',
        title: title,
        body: body,
        receiverApp: ReceiverApp.brand,
        data: data);
    // saveNotificationInDB(userid, title, body,
    //     '${ApiLinks.customerImage}/$image', route ?? '', objectid ?? 0);
  }
}
