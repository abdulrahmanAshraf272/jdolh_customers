import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'dart:async';

import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/reservation_invitors.dart';

class ResProductController extends ResParentController {
  //Checker variables

  // Create a list of invitations

  sendInvitations() async {
    List<Resinvitors> invitations = [
      Resinvitors(
          resid: 27, userid: 5, type: 1, status: 0, cost: 20.4, creatorid: 18),
      Resinvitors(
          resid: 27, userid: 5, type: 1, status: 0, cost: 20.4, creatorid: 18),
      Resinvitors(
          resid: 27, userid: 5, type: 1, status: 0, cost: 20.4, creatorid: 18),
      // Add more invitations as needed
    ];

    var response = await resData.sendInvitations(invitations);
    statusRequest = handlingData(response);
    print('add res location $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        return true;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  List<Friend> members = [];
  TextEditingController extraSeats = TextEditingController();

  // === Add Invitors===//
  switchWithInvitors(bool value) {
    withInvitation = value;
    update();
  }

  removeMember(index) {
    members.remove(members[index]);
    update();
  }

  onTapAddMembers() {
    Get.toNamed(AppRouteName.addResInvitors)!.then((value) => update());
  }

  onTapConfirmRes() async {
    if (checkAllFeilds()) {
      statusRequest = StatusRequest.loading;
      update();

      var result = await createRes();
      update();
      if (result != null) {
        //brandProfileController.carts.clear();
        if (resDetails.reviewRes == 0) {
          Get.offNamed(AppRouteName.payment, arguments: result);
        } else {
          Get.offNamed(AppRouteName.waitForApprove, arguments: result);
        }
      }
    }
  }

  bool checkAllFeilds() {
    if (brandProfileController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!');
      return false;
    }
    if (selectedDate == '') {
      Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز');
      return false;
    }
    return true;
  }

  //Timer variables
  bool timerIsActive = false;
  late Timer timer;
  int minutesTimeAllowedToConfirmReservation = 1800;
  late int remainingTime;
  late RxInt remainingMin;
  late RxInt remainingSec;
  String buttonText = textConfirmReservation;

  // ===== Timer =====//
  onTabBottomButton() {
    if (!withInvitation || (withInvitation && timerIsActive)) {
      confirmReservation();
    } else {
      //sendInvitations();
    }
  }

  // sendInvitations() {
  //   activeTimer();
  //   //TODO: add the sending notifation function
  //   print('sending notificatoin to the selected friends');
  // }

  confirmReservation() {
    print('confirm reservation and going to pay secreen');
    Get.toNamed(AppRouteName.payment);
    inactiveTimer();
  }

  activeTimer() {
    timerIsActive = true;
    _startTimer();
    buttonText = textConfirmReservation;
    update();
  }

  inactiveTimer() {
    if (timerIsActive) {
      timerIsActive = false;
      timer.cancel();
    }

    buttonText = textConfirmReservation;
    update();
  }

  activeWithInvitationOption() {
    withInvitation = true;
    buttonText = textSendInvication;
    update();
  }

  activeNoInvitationOption() {
    withInvitation = false;
    inactiveTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      remainingMin.value = (remainingTime ~/ 60);
      remainingSec.value = (remainingTime % 60);
      print(remainingMin);
      print(remainingSec);
      if (remainingTime <= 0) {
        timer.cancel();
        timerFinished();
      }
    });
  }

  timerFinished() {
    print('time finish');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //Get ResOption
    resOptions = List.from(brandProfileController.resOptions);
    resOptionsTitles = List.from(brandProfileController.resOptionsTitles);
    selectedResOption = brandProfileController.selectedResOption;
    //Timer
    remainingTime = (minutesTimeAllowedToConfirmReservation * 60);
    remainingMin = (remainingTime ~/ 60).obs;
    remainingSec = (remainingTime % 60).obs;
  }
}
