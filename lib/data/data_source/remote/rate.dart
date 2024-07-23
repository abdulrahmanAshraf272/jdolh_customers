import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class RateData {
  Crud crud;
  RateData(this.crud);

  addRate({
    required String userid,
    required String bchid,
    required String brandid,
    required String resid,
    required String ratevalue,
    required String comment,
  }) async {
    var response = await crud.postData(ApiLinks.addRate, {
      "userid": userid,
      "bchid": bchid,
      "brandid": brandid,
      "resid": resid,
      "ratevalue": ratevalue,
      "comment": comment,
    });

    return response.fold((l) => l, (r) => r);
  }

  getRate({required String resid, required String userid}) async {
    var response = await crud
        .postData(ApiLinks.getRate, {"resid": resid, "userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  deleteRate({
    required String rateid,
  }) async {
    var response = await crud.postData(ApiLinks.deleteRate, {
      "rateid": rateid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
