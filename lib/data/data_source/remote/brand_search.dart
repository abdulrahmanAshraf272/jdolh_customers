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

  getBch({required String bchid, required String userid}) async {
    var response = await crud
        .postData(ApiLinks.getBch, {"bchid": bchid, "userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  getBchInfo({required String bchid}) async {
    var response = await crud.postData(ApiLinks.getBchInfo, {
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

  getBrandBch({required String bchid}) async {
    var response = await crud.postData(ApiLinks.getBrandBch, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
