import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class NotificationData {
  Crud crud;
  NotificationData(this.crud);

  createNotification(
      {required String userid,
      required String title,
      required String body,
      required String image,
      required String route,
      required String objectid}) async {
    var response = await crud.postData(ApiLinks.createNotification, {
      "userid": userid,
      "title": title,
      "body": body,
      "image": image,
      "route": route,
      "objectid": objectid
    });

    return response.fold((l) => l, (r) => r);
  }

  getNotifications({required String userid}) async {
    var response = await crud.postData(ApiLinks.getNotifications, {
      "userid": userid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
