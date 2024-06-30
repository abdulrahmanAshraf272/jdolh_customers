import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ReservationWithInvitorsDetailsController extends GetxController {
  late Reservation reservation;
  StatusRequest statusResCart = StatusRequest.none;
  StatusRequest statusGetInvitors = StatusRequest.none;
  List<Resinvitors> resInvitors = [];
  List<Cart> carts = [];
  String resTime = '';
  bool displayResInvitorsPart = true;
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();

  changeSubscreen(bool displayResInvitor) {
    displayResInvitorsPart = displayResInvitor;
    update();
    if (!displayResInvitor && carts.isEmpty) {
      getResCart();
    }
  }

  onTapCancelReservation(String action) {
    Get.defaultDialog(
      title: "الغاء الحجز",
      middleText: 'هل تريد الغاء الحجز؟',
      textCancel: "الغاء",
      textConfirm: "تأكيد",
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        cancelReservation();
        Get.back(); // Close the dialog
      },
    );
  }

  leaveReservation() {
    respondToInvitation(2);
  }

  rejectInvitation() {
    respondToInvitation(2);
  }

  acceptInvitation() {
    respondToInvitation(1);
  }

  respondToInvitation(int status) async {
    CustomDialogs.loading();
    var response = await resData.respondInvitations(
        resid: reservation.resId.toString(),
        userid: myServices.getUserid(),
        status: status.toString());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success();
        Get.back(result: true);
      } else {
        CustomDialogs.failure();
      }
    }
  }

  cancelReservation() async {
    CustomDialogs.loading();
    var response = await resData.changeResStatus(
        resid: reservation.resId.toString(), status: '4', rejectionReason: '');
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success();
        Get.back(result: true);
      } else {
        CustomDialogs.failure();
      }
    }
  }

  getResCart() async {
    statusResCart = StatusRequest.loading;
    update();
    var response =
        await resData.getResCart(resid: reservation.resId.toString());
    statusResCart = handlingData(response);
    print('statusRequest ==== $statusResCart');
    if (statusResCart == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        carts = data.map((e) => Cart.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  getInvitors() async {
    statusGetInvitors = StatusRequest.loading;
    update();
    var response =
        await resData.getInvitors(resid: reservation.resId.toString());
    statusGetInvitors = handlingData(response);
    print('statusGetInvitors: ${statusGetInvitors}');
    if (statusGetInvitors == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseGetInvitors(response);
      } else {
        statusGetInvitors = StatusRequest.failure;
      }
    }
    update();
  }

  parseGetInvitors(response) {
    print('success get invitors');
    List data = response['data'];
    resInvitors.clear();
    resInvitors = data.map((e) => Resinvitors.fromJson(e)).toList();
  }

  onTapDisplayLocation() {
    double lat = double.parse(reservation.bchLat!);
    double lng = double.parse(reservation.bchLng!);
    Get.toNamed(AppRouteName.diplayLocation, arguments: LatLng(lat, lng));
  }

  String displayResTime(String timeString) {
    timeString = timeString.trim();
    DateTime time = DateFormat.Hm().parse(timeString);
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  callBch() {
    String contactNumber = reservation.bchContactNumber ?? '';
    if (contactNumber == '') {
      Get.rawSnackbar(message: 'الرقم غير صالح');
      return;
    }
    openContactApp(contactNumber);
  }

  //TODO to get reservation in case onTap notification
  getReservation() {}

  receiveArgument() async {
    if (Get.arguments['res'] is Reservation) {
      reservation = Get.arguments['res'];
    } else {
      reservation = await getReservation();
    }
  }

  @override
  void onInit() async {
    await receiveArgument();
    resTime = displayResTime(reservation.resTime!);
    super.onInit();
  }
}
