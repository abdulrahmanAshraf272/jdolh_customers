import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/sweet_bottom_sheet.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/wallet.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:sweetsheet/sweetsheet.dart';

class TransferMoneyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Friend? selectedUser;
  WalletData walletData = WalletData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController amount = TextEditingController();

  onTapAddMembers() async {
    List<Friend> members = [];
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result != null) {
      if (result is Friend) {
        selectedUser = result;
        update();
      }
    }
  }

  onTapTransferMoney(BuildContext context) {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      if (selectedUser == null) {
        Get.rawSnackbar(message: 'من فضلك اختر المستخدم');
        return;
      } else if (amount.text == '0') {
        Get.rawSnackbar(message: 'من فضلك حدد المبلغ الذي تريد تحويله');
        return;
      }

      sweetBottomSheet(
          context: context,
          title: 'تحويل رصيد',
          desc:
              'هل تريد تحويل مبلغ ${amount.text} ريال الى ${selectedUser!.userName} ؟'
                  .tr,
          confirmButtonText: 'تأكيد'.tr,
          onTapConfirm: () {
            Get.back();
            transferMoney();
          },
          color: SweetSheetColor.SUCCESS,
          icon: Icons.attach_money);
    }
  }

  transferMoney() async {
    double amountDouble = double.parse(amount.text);
    String amountFormatted = amountDouble.toStringAsFixed(2);

    CustomDialogs.loading();
    var response = await walletData.customerTransferMoney(
        from: myServices.getUserid(),
        to: selectedUser!.userId.toString(),
        amount: amountFormatted);
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم تحويل المبلغ');
        Get.back(result: true);
      } else if (response['message'] == 'not enough money') {
        CustomDialogs.failure('لا يوجد رصيد كافي');
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }
}
