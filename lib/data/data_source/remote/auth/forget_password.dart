import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class ForgetPasswordData {
  Crud crud;
  ForgetPasswordData(this.crud);

  postData(String usernameOrEmail) async {
    var response = await crud.postData(ApiLinks.forgetPassword, {
      "usernameOrEmail": usernameOrEmail,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
