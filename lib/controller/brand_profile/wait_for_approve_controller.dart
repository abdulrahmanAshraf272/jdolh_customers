import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
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

  changeRejectStatusToSeen() async {
    var response = await resData.changeResStatus(
        resid: reservation.resId.toString(), status: '-2', rejectionReason: '');
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('change rejected res to seend is done');
      }
    }
  }

  onTapDeleteRes() async {
    CustomDialogs.loading();
    var result = await deleteRes();
    CustomDialogs.dissmissLoading();

    if (result == true) {
      CustomDialogs.success('تم الغاء الحجز'.tr);
      goHomeScreen();
    } else {
      CustomDialogs.failure();
    }
  }

  getRes() async {
    // statusRequest = StatusRequest.loading;
    // update();
    var response = await resData.getRes(resid: reservation.resId.toString());
    statusRequest = handlingData(response);
    print('getRes === $statusRequest');
    if (statusRequest == StatusRequest.success) {
      print(response);
      if (response['status'] == 'success') {
        Reservation result = Reservation.fromJson(response['data']);
        reservation.resStatus = result.resStatus;
        reservation.resRejectionReason = result.resRejectionReason;
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

  goHomeAfterDeleteRes() async {
    deleteRes();
    goHomeScreen();
  }

  Future<bool> deleteRes() async {
    var response =
        await resData.deleteReservation(resid: reservation.resId.toString());
    StatusRequest statusDelete = handlingData(response);
    if (statusDelete == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete reservation done successfuly');
        return true;
      } else {
        print('delete reservation failed: ${response['message']}');
        return false;
      }
    } else {
      print('delete res failed: $statusDelete');
      return false;
    }
  }

  Future<bool> confirmRes() async {
    int resPayed = 0;
    int billPayed = 0;
    int status = 3;
    if (reservation.resPaymentType == 'R' && reservation.resResCost == 0) {
      resPayed = 1;
    } else if (reservation.resPaymentType == 'RB' &&
        reservation.resResCost == 0 &&
        reservation.resBillCost == 0) {
      resPayed = 1;
      billPayed = 1;
    }
    print('resPayed: $resPayed');
    print('billPayed: $billPayed');
    CustomDialogs.loading();
    var response = await resData.confirmRes(
        resid: reservation.resId.toString(),
        status: status.toString(),
        resPayed: resPayed.toString(),
        billPayed: billPayed.toString());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('confirm res is done successfuly');
        return true;
      } else {
        print('failure: ${response['message']}');
      }
    }
    return false;
  }

  goHomeScreen() {
    if (reservation.resStatus == 2) {
      changeRejectStatusToSeen();
    }
    Get.offAllNamed(AppRouteName.mainScreen);
  }

  gotoPayment() async {
    if (await checkIfNoCostToPay() == true) {
      return;
    }

    Get.offNamed(AppRouteName.payment, arguments: {
      "res": reservation,
      "resPolicy": resPolicy,
      "billPolicy": billPolicy,
    });
  }

  Future<bool> checkIfNoCostToPay() async {
    if ((reservation.resPaymentType == 'R' && reservation.resResCost == 0) ||
        (reservation.resPaymentType == 'RB' &&
            reservation.resResCost == 0 &&
            reservation.resBillCost == 0)) {
      await confirmRes();
      Get.offNamed(AppRouteName.paymentResult,
          arguments: {"res": reservation, "paymentMethod": 'wallet'});
      return true;
    }

    return false;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments['res'];
      resPolicy = Get.arguments['resPolicy'];
      billPolicy = Get.arguments['billPolicy'];

      getRes();
    } else {
      print('reserved nothing from previus screen');
    }
    super.onInit();
  }
}
