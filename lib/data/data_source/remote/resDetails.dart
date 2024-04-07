import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class ResDetailsData {
  Crud crud;
  ResDetailsData(this.crud);

  getResDetails({
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.getResDetails, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
