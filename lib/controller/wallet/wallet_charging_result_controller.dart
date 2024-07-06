import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/wallet.dart';

class WalletChargingResultController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  WalletData walletData = WalletData(Get.find());
  String? amount;
  String? orderId;

  String newBalance = '';

  checkPaymentResult() async {
    if (amount == null || orderId == null) {
      CustomDialogs.failure();
      return;
    }

    statusRequest = StatusRequest.loading;
    update();
    var response = await walletData.chargeCustomerWallet(
        orderId: orderId!, userid: myServices.getUserid(), amount: amount!);
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        newBalance = response['data'];
      } else {
        print(response);
      }
    }
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      amount = Get.arguments['amount'];
      orderId = Get.arguments['orderId'];

      checkPaymentResult();
    }
    super.onInit();
  }
}
