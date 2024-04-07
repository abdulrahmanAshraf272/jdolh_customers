import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class ActivityData {
  Crud crud;
  ActivityData(this.crud);

  getFriendsActivities({
    required String userid,
  }) async {
    var response = await crud.postData(ApiLinks.getFriendsActivities, {
      "userid": userid,
    });

    return response.fold((l) => l, (r) => r);
  }

  getUserActivities({
    required String userid,
  }) async {
    var response = await crud.postData(ApiLinks.getUserActivities, {
      "userid": userid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
