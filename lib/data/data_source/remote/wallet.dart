import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class WalletData {
  Crud crud;
  WalletData(this.crud);

  cutomerWalletBalance(String userid) async {
    var response =
        await crud.postData(ApiLinks.customerWalletBalance, {"userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  customerWalletTransferHistory(String userid) async {
    var response = await crud
        .postData(ApiLinks.customerWalletTransHistory, {"userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  customerTransferMoney(
      {required String from,
      required String to,
      required String amount}) async {
    var response = await crud.postData(ApiLinks.customerTransferMoney,
        {"from": from, "to": to, "amount": amount});

    return response.fold((l) => l, (r) => r);
  }

  chargeCustomerWallet(
      {required String orderId,
      required String userid,
      required String amount}) async {
    var response = await crud.postData(ApiLinks.chargeCustomerWallet,
        {"orderId": orderId, "userid": userid, "amount": amount});

    return response.fold((l) => l, (r) => r);
  }
}
