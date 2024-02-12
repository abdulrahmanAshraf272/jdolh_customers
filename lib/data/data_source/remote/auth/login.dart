import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  postData(String usernameOrEmail, String password) async {
    var response = await crud.postData(ApiLinks.login, {
      "usernameOrEmail": usernameOrEmail,
      "password": password,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
