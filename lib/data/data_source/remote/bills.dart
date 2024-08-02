import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class BillsData {
  Crud crud;
  BillsData(this.crud);

  createBill(
      {required String resid,
      required String userid,
      required String brandId,
      required String bchId,
      required String taxPercent,
      required String taxAmount,
      required String amountWithoutTax,
      required String amount,
      required String paymentMethod,
      required String vatNo,
      required String crNo,
      required String file,
      required String type}) async {
    var response = await crud.postData(ApiLinks.createBill, {
      "resid": resid,
      "userid": userid,
      "brandId": brandId,
      "bchId": bchId,
      "taxPercent": taxPercent,
      "taxAmount": taxAmount,
      "amountWithoutTax": amountWithoutTax,
      "amount": amount,
      "paymentMethod": paymentMethod,
      "vatNo": vatNo,
      "crNo": crNo,
      "file": file,
      "type": type
    });

    return response.fold((l) => l, (r) => r);
  }

  divideBill(
      {required String resid,
      required String brandId,
      required String bchId,
      required String userid,
      required String taxPercent,
      required String taxAmount,
      required String amountWithoutTax,
      required String amount,
      required String file,
      required String billId,
      required String vatNo,
      required String crNo}) async {
    var response = await crud.postData(ApiLinks.divideBill, {
      "resid": resid,
      "brandId": brandId,
      "bchId": bchId,
      "userid": userid,
      "taxPercent": taxPercent,
      "taxAmount": taxAmount,
      "amountWithoutTax": amountWithoutTax,
      "amount": amount,
      "file": file,
      "billId": billId,
      "vatNo": vatNo,
      "crNo": crNo
    });

    return response.fold((l) => l, (r) => r);
  }

  getOriginalBill(String resId) async {
    var response =
        await crud.postData(ApiLinks.getOriginalBill, {"resId": resId});

    return response.fold((l) => l, (r) => r);
  }

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
      required String userId,
      required String isOriginal}) async {
    var response = await crud.postData(ApiLinks.payBillCredit, {
      "orderId": orderId,
      "billId": billId,
      "amountWithoutTax": amountWithoutTax,
      "tax": tax,
      "totalAmount": totalAmount,
      "resId": resId,
      "paymentMethod": paymentMethod,
      "brandId": brandId,
      "userId": userId,
      "isOriginal": isOriginal
    });

    return response.fold((l) => l, (r) => r);
  }

  payBillWallet(
      {required String userId,
      required String billId,
      required String amountWithoutTax,
      required String tax,
      required String totalAmount,
      required String resId,
      required String brandId,
      required String isOriginal}) async {
    var response = await crud.postData(ApiLinks.payBillWallet, {
      "userId": userId,
      "billId": billId,
      "amountWithoutTax": amountWithoutTax,
      "tax": tax,
      "totalAmount": totalAmount,
      "resId": resId,
      "brandId": brandId,
      "isOriginal": isOriginal
    });

    return response.fold((l) => l, (r) => r);
  }

  payBillCash({required String billId}) async {
    var response =
        await crud.postData(ApiLinks.payBillCash, {"billId": billId});

    return response.fold((l) => l, (r) => r);
  }
}
