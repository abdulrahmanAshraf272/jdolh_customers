import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class BrandSearchData {
  Crud crud;
  BrandSearchData(this.crud);

  searchBrand(String city, String brandType, String brandSubtype) async {
    var response = await crud.postData(ApiLinks.searchBrand, {
      "city": city,
      "brandType": brandType,
      "brandSubtype": brandSubtype,
    });

    return response.fold((l) => l, (r) => r);
  }

  getBch({required String bchid}) async {
    var response = await crud.postData(ApiLinks.getBch, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  getTypesAndSubtypes() async {
    var response = await crud.getData(ApiLinks.brandTypesAndsubtypes);

    return response.fold((l) => l, (r) => r);
  }

  getItemOptionsWithElements({required String itemId}) async {
    var response = await crud.postData(ApiLinks.getItemOptions, {
      "itemId": itemId,
    });

    return response.fold((l) => l, (r) => r);
  }
}
