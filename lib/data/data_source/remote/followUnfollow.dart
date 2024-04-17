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

  followBch({required String userid, required String bchid}) async {
    var response = await crud.postData(ApiLinks.followBch, {
      "userid": userid,
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  getAllUsers({required String myId}) async {
    var response = await crud.postData(ApiLinks.getAllUsers, {
      "myId": myId,
    });

    return response.fold((l) => l, (r) => r);
  }
}
