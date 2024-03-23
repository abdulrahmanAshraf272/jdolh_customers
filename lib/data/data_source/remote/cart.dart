import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class CartData {
  Crud crud;
  CartData(this.crud);

  addCart({
    required String userid,
    required String bchid,
    required String itemid,
    required String price,
    required String quantity,
    required String totalPrice,
    required String discount,
    required String desc,
    required String shortDesc,
  }) async {
    var response = await crud.postData(ApiLinks.addCart, {
      "userid": userid,
      "bchid": bchid,
      "itemid": itemid,
      "price": price,
      "quantity": quantity,
      "totalPrice": totalPrice,
      "discount": discount,
      "desc": desc,
      "shortDesc": shortDesc,
    });

    return response.fold((l) => l, (r) => r);
  }

  getCart({
    required String userid,
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.getCart, {
      "userid": userid,
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteCart({required String cartid}) async {
    var response = await crud.postData(ApiLinks.deleteCart, {
      "cartid": cartid,
    });

    return response.fold((l) => l, (r) => r);
  }

  changeQuantity(
      {required String cartid,
      required String quantity,
      required String totalPrice}) async {
    var response = await crud.postData(ApiLinks.changeQuantity,
        {"cartid": cartid, "quantity": quantity, "totalPrice": totalPrice});

    return response.fold((l) => l, (r) => r);
  }
}
