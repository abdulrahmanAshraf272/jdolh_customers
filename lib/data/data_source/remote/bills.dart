import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class BillsData {
  Crud crud;
  BillsData(this.crud);

  getCustomerBills(String userid) async {
    var response =
        await crud.postData(ApiLinks.getCustomerBills, {"userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  payBillCredit(
      {required String orderId,
      required String billId,
      required String amountWithoutTax,
      required String tax,
      required String totalAmount,
      required String resId,
      required String paymentMethod,
      required String brandId,
      required String userId}) async {
    var response = await crud.postData(ApiLinks.payBillCredit, {
      "orderId": orderId,
      "billId": billId,
      "amountWithoutTax": amountWithoutTax,
      "tax": tax,
      "totalAmount": totalAmount,
      "resId": resId,
      "paymentMethod": paymentMethod,
      "brandId": brandId,
      "userId": userId
    });

    return response.fold((l) => l, (r) => r);
  }

  payBillWallet(
      {required String orderId,
      required String userId,
      required String billId,
      required String amountWithoutTax,
      required String tax,
      required String totalAmount,
      required String resId,
      required String brandId}) async {
    var response = await crud.postData(ApiLinks.payBillWallet, {
      "userId": userId,
      "orderId": orderId,
      "billId": billId,
      "amountWithoutTax": amountWithoutTax,
      "tax": tax,
      "totalAmount": totalAmount,
      "resId": resId,
      "brandId": brandId
    });

    return response.fold((l) => l, (r) => r);
  }

  payBillCash({required String billId}) async {
    var response =
        await crud.postData(ApiLinks.payBillCash, {"billId": billId});

    return response.fold((l) => l, (r) => r);
  }
}
