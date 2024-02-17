import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class FollowUnfollowData {
  Crud crud;
  FollowUnfollowData(this.crud);

  postData(String myId, String personId) async {
    var response = await crud.postData(ApiLinks.followUnfollow, {
      "myId": myId,
      "personId": personId,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
