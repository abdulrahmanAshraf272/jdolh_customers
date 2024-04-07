import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class WaitForApproveController extends GetxController {
  ApproveStatus approveStatus = ApproveStatus.waiting;

  Reservation reservation = Reservation();
  String rejectionReason = '';
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());

  getRes() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.getRes(resid: reservation.resId.toString());
    statusRequest = handlingData(response);
    print('getRes === $statusRequest');
    if (statusRequest == StatusRequest.success) {
      print(response);
      if (response['status'] == 'success') {
        reservation = Reservation.fromJson(response['data']);
        print('status ${reservation.resStatus}');
        if (reservation.resStatus == 1) {
          approveStatus = ApproveStatus.approved;
        } else if (reservation.resStatus == 2) {
          approveStatus = ApproveStatus.rejected;
          rejectionReason = reservation.resRejectionReason ?? '';
        }
      }
    }
    print('approveStatus $approveStatus');
    update();
  }

  gotoPayment() {
    Get.offNamed(AppRouteName.payment, arguments: reservation);
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments;
    } else {
      print('reserved nothing from previus screen');
    }
    super.onInit();
  }
}
