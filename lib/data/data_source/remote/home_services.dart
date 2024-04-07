import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class HomeServicesData {
  Crud crud;
  HomeServicesData(this.crud);

  homeServicesAvailableSwitch(
      {required String bchid, required String value}) async {
    var response = await crud.postData(
        ApiLinks.homeServiceAvailable, {"bchid": bchid, "value": value});

    return response.fold((l) => l, (r) => r);
  }

  getHomeServices({required String bchid}) async {
    var response =
        await crud.postData(ApiLinks.getHomeServices, {"bchid": bchid});

    return response.fold((l) => l, (r) => r);
  }
}
