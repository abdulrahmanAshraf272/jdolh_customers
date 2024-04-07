import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class PaymentController extends GetxController {
  ResData resData = ResData(Get.find());
  StatusRequest statusRequest = StatusRequest.loading;
  Reservation reservation = Reservation();
  String resPolicy = '';
  String billPolicy = '';
  num resCost = 0;
  num billCost = 0;

  onTapConfirm() {
    changeResStatus('3');
    Get.offAllNamed(AppRouteName.mainScreen);
  }

  changeResStatus(String status) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.changeResStatus(
        resid: reservation.resId.toString(),
        status: status,
        rejectionReason: '');
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
      } else {
        print('failure');
      }
    }
    update();
  }

  getPolicesTitle() async {
    var response = await resData.getPolicyTitle(
        resPolicyid: reservation.resResPolicy.toString(),
        billPolicyid: reservation.resBillPolicy.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        resPolicy = response['resPolicy'];
        billPolicy = response['billPolicy'];
        print(resPolicy);
        print(billPolicy);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onTapPay() {}

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments;
      resCost = reservation.resResCost ?? 0;
      billCost = reservation.resTotalPrice ?? 0 - resCost;
    } else {
      print('reserved nothing from previus screen');
    }
    getPolicesTitle();
    super.onInit();
  }
}
