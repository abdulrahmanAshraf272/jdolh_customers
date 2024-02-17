import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class PersonProfileData {
  Crud crud;
  PersonProfileData(this.crud);

  postData(String userId, String myId) async {
    var response = await crud
        .postData(ApiLinks.personProfile, {"userId": userId, "myId": myId});

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
