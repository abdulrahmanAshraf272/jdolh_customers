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

  getUserActivities({required String userid, required String myId}) async {
    var response = await crud
        .postData(ApiLinks.getUserActivities, {"userid": userid, "myId": myId});

    return response.fold((l) => l, (r) => r);
  }

  likeUnlikeActivity(
      {required String userid,
      required String activityType,
      required String activityId,
      required String like}) async {
    var response = await crud.postData(ApiLinks.likeUnlikeActivity, {
      "userid": userid,
      "activityType": activityType,
      "activityId": activityId,
      "like": like,
    });

    return response.fold((l) => l, (r) => r);
  }
}
