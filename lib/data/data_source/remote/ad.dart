import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class AdData {
  Crud crud;
  AdData(this.crud);

  getAllAds() async {
    var response = await crud.getData(ApiLinks.getAllAds);

    return response.fold((l) => l, (r) => r);
  }

  increaseClickNumber({required String adId}) async {
    var response =
        await crud.postData(ApiLinks.increaseClickNumber, {"adId": adId});

    return response.fold((l) => l, (r) => r);
  }
}
