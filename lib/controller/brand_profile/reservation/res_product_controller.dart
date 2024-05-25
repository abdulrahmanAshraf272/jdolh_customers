import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'dart:async';

import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/res_invitors.dart';

class ResProductController extends ResParentController {
  List<Resinvitors> resInvitors = [];
  //BrandProfileController brandProfileController =Get.put(BrandProfileController());
  //Checker variables

  // Create a list of invitations

  List<Friend> members = [];
  TextEditingController extraSeats = TextEditingController();

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result is Friend) {
      members.add(result);
      Resinvitors invitor = Resinvitors(
          userid: result.userId,
          userName: result.userName,
          userImage: result.userImage,
          type: 0,
          cost: 0);
      resInvitors.add(invitor);
      update();
    }
  }

  gotoInvitorsBills() {
    num totalCost =
        cartController.totalPrice + resCost + cartController.taxCost;
    int totalPeopleNo = resInvitors.length + 1; // 1 is me.
    if (extraSeats.text != '') {
      totalPeopleNo += int.parse(extraSeats.text);
    }
    num personCost = totalCost / totalPeopleNo;
    int numberOfNoCostPeople = 0;
    int numberOfDividePeople = 0;
    int numberOfNormalPeople = 0;
    for (int i = 0; i < resInvitors.length; i++) {
      switch (resInvitors[i].type) {
        case 0:
          numberOfNormalPeople++;
          break;
        case 1:
          numberOfDividePeople++;
          break;
        case 2:
          numberOfNoCostPeople++;
          break;
      }
    }
    numberOfDividePeople += 1; //1 is me.
    if (extraSeats.text != '') {
      numberOfNoCostPeople += int.parse(extraSeats.text);
    }

    num billOfNoCostPeople = personCost * numberOfNoCostPeople;
    //======
    num costOfNormalPeople = personCost;
    num costOfnoCostPeople = 0;
    num costOfDividePeople =
        personCost + (billOfNoCostPeople / numberOfDividePeople);

    print('total cost: $totalCost');
    print('total people: $totalPeopleNo');
    print('person cost: $personCost');
    print('==========');
    print('number of noCostPeople: $numberOfNoCostPeople');
    print('number of dividePeople: $numberOfDividePeople');
    print('number of normalPeople: $numberOfNormalPeople');
    print('======');
    print('bill of noCostPeople: $billOfNoCostPeople');
    print('===');
    print('cost of normal person (type = 0): $costOfNormalPeople');
    print('cost of dividedCostPeople (type = 1): $costOfDividePeople');
    print('cost of noCostPeople(type = 2): $costOfnoCostPeople');
  }

  onTapPayForHimself(int index) {
    resInvitors[index].type = 0;
    update();
  }

  onTapDivideBill(int index) {
    resInvitors[index].type = 1;
    update();
  }

  onTapWithoutPayBill(int index) {
    resInvitors[index].type = 2;
    update();
  }

  // === Add Invitors===//
  switchWithInvitors(bool value) {
    withInvitation = value;
    update();
  }

  removeMember(index) {
    resInvitors.removeAt(index);
    update();
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
    if (cartController.carts.isEmpty) {
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
