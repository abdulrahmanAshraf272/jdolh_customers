import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/notification.dart';
import 'package:jdolh_customers/data/models/my_notification.dart';

class NotificationsController extends GetxController {
  NotificationData notificationData = NotificationData();
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  List<MyNotification> notifications = [];

  onTap(int index) {
    if (notifications[index].route != null &&
            notifications[index].route != '' ||
        notifications[index].route != AppRouteName.waitForApprove) {
      dynamic objectid = notifications[index].objectid;
      Get.toNamed(notifications[index].route!, arguments: objectid);
    }
  }

  getNotifications() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await notificationData.getNotifications(userid: myServices.getUserid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        notifications = data.map((e) => MyNotification.fromJson(e)).toList();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }
}
