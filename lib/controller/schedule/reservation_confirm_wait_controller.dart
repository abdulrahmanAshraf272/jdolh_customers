import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ReservationConfirmWaitController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusGetInvitors = StatusRequest.none;
  late Reservation reservation;
  late List<Resinvitors> resInvitors;
  List<Cart> carts = [];
  String resTime = '';
  ResData resData = ResData(Get.find());

  bool displayResInvitorsPart = true;

  changeSubscreen(bool displayResInvitor) {
    displayResInvitorsPart = displayResInvitor;
    update();
    if (!displayResInvitor && carts.isEmpty) {
      getResCart();
    }
  }

  onTapConfirmReservation() async {
    inactiveTimer();
  }

  //TODO:
  confirmReservation() {}

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

  void goBackAlert() {
    Get.defaultDialog(
        title: 'الغاء الحجز',
        middleText: 'اذا قمت بالخروج الصفحة سوف يتم الغاء الحجز',
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('خروج'),
          ),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('الغاء'))
        ]);
  }

  cancelReservation() async {
    var response =
        await resData.deleteReservation(resid: reservation.resId.toString());
    StatusRequest statusRequestDelete = handlingData(response);
    print('statusRequest ==== $statusRequestDelete');
    if (statusRequestDelete == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete reservation done successfuly');
      } else {
        print('failure');
      }
    }
  }

  getResCart() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await resData.getResCart(resid: reservation.resId.toString());
    statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseResCart(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parseResCart(response) {
    List data = response['data'];
    carts = data.map((e) => Cart.fromJson(e)).toList();
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

  // #################{{ TIMER }}##################//
  bool timerIsActive = false;
  late Timer timer;
  RxInt remainingTime = 70.obs;

  activeTimer() {
    timerIsActive = true;
    _startTimer();
    update();
  }

  inactiveTimer() {
    if (timerIsActive) {
      timerIsActive = false;
      timer.cancel();
    }
    update();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      if (remainingTime <= 0) {
        timer.cancel();
        timerFinished();
      }
    });
  }

  timerFinished() {
    print('time finish');
    Get.back();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments['reservation'];
      remainingTime.value =
          Get.arguments['holdTime'] * 60; //to convert time to seconds
      resInvitors = Get.arguments['resInvitors'];

      print('brand logo: ${reservation.brandLogo}');
      ;
      print('contract number: ${reservation.bchContactNumber}');

      print('hold time : $remainingTime');
    }
    _startTimer();
    resTime = displayResTime(reservation.resTime!);
    super.onInit();
  }

  @override
  void onClose() {
    cancelReservation();
    timer.cancel();
    super.onClose();
  }
}
