import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/policy.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class WaitForApproveController extends GetxController {
  ApproveStatus approveStatus = ApproveStatus.waiting;

  Reservation reservation = Reservation();
  String rejectionReason = '';
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());

  List<Cart> carts = [];
  late Policy resPolicy;
  late Policy billPolicy;
  late Brand brand;

  getRes() async {
    // statusRequest = StatusRequest.loading;
    // update();
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
    Get.offNamed(AppRouteName.payment, arguments: {
      "res": reservation,
      "resPolicy": resPolicy,
      "billPolicy": billPolicy,
      "brand": brand
    });
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments['res'];
      resPolicy = Get.arguments['resPolicy'];
      billPolicy = Get.arguments['billPolicy'];
      brand = Get.arguments['brand'];
    } else {
      print('reserved nothing from previus screen');
    }
    super.onInit();
  }
}
