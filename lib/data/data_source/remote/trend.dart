import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class TrendData {
  Crud crud;
  TrendData(this.crud);

  getTopRate(String myId) async {
    var response = await crud.postData(ApiLinks.getTopRate, {"myId": myId});

    return response.fold((l) => l, (r) => r);
  }

  getTopCheckin() async {
    var response = await crud.getData(ApiLinks.getTopCheckin);

    return response.fold((l) => l, (r) => r);
  }

  getTopRes() async {
    var response = await crud.getData(ApiLinks.getTopRes);

    return response.fold((l) => l, (r) => r);
  }

  getTopCheckinPeople(String placeid, String myId) async {
    var response = await crud.postData(
        ApiLinks.geetTopCheckinPeople, {"placeid": placeid, "myId": myId});

    return response.fold((l) => l, (r) => r);
  }
}
