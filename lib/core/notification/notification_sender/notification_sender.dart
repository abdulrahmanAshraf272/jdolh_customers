import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/notification/notification_const.dart';
import 'package:jdolh_customers/core/notification/notification_data.dart';
import 'package:jdolh_customers/core/services/services.dart';

abstract class NotificationSender {
  MyServices myServices = Get.find();

  static sendFollowingPersonLikeActivity(
      int? userId, int myId, String myName, String myImage, String type) {
    if (userId == null) return;
    String typeText = '';
    if (type == 'checkin') {
      typeText = 'تسجيل وصول';
    } else {
      typeText = 'تقييم';
    }
    print('like notification =================');
    sendToCustomer(
        userid: userId,
        title: 'لديك اعجاب جديد',
        body: 'قام $myName بالإعجاب على $typeText قمت به',
        routeName: AppRouteName.personProfile,
        objectId: myId,
        image: "${ApiLinks.customerImage}/$myImage");
  }

  static sendFollowingPerson(
      int? userId, int myId, String myName, String myImage) {
    if (userId == null) return;
    String image = "${ApiLinks.customerImage}/$myImage";
    print('image: $image');
    sendToCustomer(
        userid: userId,
        title: 'قام $myName بمتابعتك',
        body: 'قام $myName بمتابعتك على تطبيق جدولة',
        routeName: AppRouteName.personProfile,
        objectId: myId,
        image: image);
  }

  static sendToMyFollower({
    required String myId,
    required String title,
    required String body,
    String routeName = '',
    String image = '',
    int objectId = -1,
    String datetime = '',
  }) {
    Map<String, dynamic> data = {
      "routeName": routeName,
      "objectId": objectId,
      "image": image,
      "datetime": datetime
    };
    print('from sendToCustomer ======');
    print(data['routeName']);
    print(data['objectId']);
    print(data['image']);
    print(data['datetime']);
    sendNotification(
        topic: '$followUserSubscribe-$myId',
        title: title,
        body: body,
        receiverApp: ReceiverApp.customer,
        data: data);
  }

  static sendToCustomer({
    required int userid,
    required String title,
    required String body,
    String routeName = '',
    String image = '',
    int objectId = -1,
    String datetime = '',
  }) {
    Map<String, dynamic> data = {
      "routeName": routeName,
      "objectId": objectId,
      "image": image,
      "datetime": datetime
    };
    print('from sendToCustomer ======');
    print(data['routeName']);
    print(data['objectId']);
    print(data['image']);
    print(data['datetime']);
    sendNotification(
        topic: '$userSubscribe-$userid',
        title: title,
        body: body,
        receiverApp: ReceiverApp.customer,
        data: data);
  }

  static sendToBch({
    required int bchid,
    required String title,
    required String body,
    String routeName = '',
    String image = '',
    int objectId = -1,
    String datetime = '',
  }) {
    Map<String, dynamic> data = {
      "routeName": routeName,
      "objectId": objectId,
      "image": image,
      "datetime": datetime
    };
    sendNotification(
        topic: '$bchSubscribe-$bchid',
        title: title,
        body: body,
        receiverApp: ReceiverApp.brand,
        data: data);
  }
}
