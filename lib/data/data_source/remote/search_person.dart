import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class SearchPersonData {
  Crud crud;
  SearchPersonData(this.crud);

  postData(String myId, String personName) async {
    var response = await crud.postData(ApiLinks.searchPerson, {
      "myId": myId,
      "personName": personName,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
