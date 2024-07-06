import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/wallet.dart';
import 'package:jdolh_customers/data/models/user.dart';

class TransferMoneyController extends GetxController {
  User? selectedUser;
  WalletData walletData = WalletData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController amount = TextEditingController();

  onTapTransferMoney() {
    if (selectedUser == null) {
      Get.rawSnackbar(message: 'من فضلك اختر المستخدم');
      return;
    } else if (amount.text == '0') {
      Get.rawSnackbar(message: 'من فضلك حدد المبلغ الذي تريد تحويله');
      return;
    }

    transferMoney();
  }

  transferMoney() async {
    double amountDouble = double.parse(amount.text);

    CustomDialogs.loading();
    var response = await walletData.customerTransferMoney(
        from: myServices.getUserid(),
        to: selectedUser!.userId.toString(),
        amount: amountDouble.toStringAsFixed(2));
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['response'] == 'success') {
        CustomDialogs.success('تم تحويل المبلغ');
        Get.back(result: true);
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }
}
