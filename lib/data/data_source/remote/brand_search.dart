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

  getBch(
      {required String bchid,
      required String userid,
      required String brandid}) async {
    var response = await crud.postData(ApiLinks.getBch,
        {"bchid": bchid, "userid": userid, "brandid": brandid});

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

  getAllBchs({required String brandid}) async {
    var response = await crud.postData(ApiLinks.getAllBchs, {
      "brandid": brandid,
    });

    return response.fold((l) => l, (r) => r);
  }

  getBchFollowers({required String bchId}) async {
    var response = await crud.postData(ApiLinks.getBchFollowers, {
      "bchId": bchId,
    });

    return response.fold((l) => l, (r) => r);
  }
}
