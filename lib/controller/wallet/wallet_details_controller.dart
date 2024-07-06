import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/wallet.dart';
import 'package:jdolh_customers/data/models/transaction.dart';

class WalletDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  WalletData walletData = WalletData(Get.find());
  MyServices myServices = Get.find();
  String walletBalance = '0.00';
  List<Transaction> walletTransaction = [];

  onTapGoToChargeWallet() {
    Get.toNamed(AppRouteName.walletCharging);
  }

  onTapGoToTransferMoneyToFriend() async {
    final result = await Get.toNamed(AppRouteName.transferMoney);
    if (result != null) {
      getWalletTransHistory();
    }
  }

  getWalletTransHistory() async {
    statusRequest = StatusRequest.loading;
    update();

    var response =
        await walletData.customerWalletTransferHistory(myServices.getUserid());
    statusRequest = handlingData(response);
    update();

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        walletBalance = response['balance'];

        List list = response['history'];
        walletTransaction = list.map((e) => Transaction.fromJson(e)).toList();
      }
    }
    update();
  }

  @override
  void onInit() {
    getWalletTransHistory();
    super.onInit();
  }
}
