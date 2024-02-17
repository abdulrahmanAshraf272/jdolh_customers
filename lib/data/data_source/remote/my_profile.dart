import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class MyProfileData {
  Crud crud;
  MyProfileData(this.crud);

  postData(String myId) async {
    var response = await crud.postData(ApiLinks.myProfile, {"myId": myId});

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
