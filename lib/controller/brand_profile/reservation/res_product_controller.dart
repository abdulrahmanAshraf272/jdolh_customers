import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'dart:async';

import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/resOption.dart';

class ResProductController extends GetxController {
  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  late ResOption selectedResOption;
  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
    print('resOption ${selectedResOption.resoptionsTitle}');
  }

  BrandProfileController brandProfileController = Get.find();
  //Checker variables
  bool withInvitation = false;
  String selectedResDateTime = '';
  TextEditingController extraSeats = TextEditingController();

  // === Add Invitors===//
  bool withInvitros = false;
  switchWithInvitors(bool value) {
    withInvitros = value;
    update();
  }

  List<Friend> members = [];
  removeMember(index) {
    members.remove(members[index]);
    update();
  }

  onTapAddMembers() {
    Get.toNamed(AppRouteName.addResInvitors)!.then((value) => update());
  }

  void gotoSetResTime() async {
    print(brandProfileController.carts.length);
    if (brandProfileController.carts.isEmpty) {
      String message = brandProfileController.brand.brandIsService == 1
          ? 'من فضلك قم بإضافة الخدمات ثم قم بتحديد وقت الحجز'
          : 'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز';
      Get.rawSnackbar(message: message);
      return;
    }
    final result = await Get.toNamed(AppRouteName.setResTime);
    if (result != null) {
      selectedResDateTime = result;
      print(selectedResDateTime);
      update();
    }
  }

  checkAllItemsAvailableWithinResOptionSelected() {
    List<dynamic> resItemsId =
        brandProfileController.selectedResOption.itemsRelated!;
    for (int i = 0; i < brandProfileController.carts.length; i++) {
      if (!resItemsId.contains(brandProfileController.carts[i].itemsId)) {
        String warningMessage =
            '${brandProfileController.carts[i].itemsTitle} غير متوفر ضمن تفضيل ${brandProfileController.selectedResOption.resoptionsTitle}\n قم بإزالة ${brandProfileController.carts[i].itemsTitle} او قم بتغيير التفضيل';
        print(warningMessage);
        return warningMessage;
      }
    }
    return true;
  }

  onTapConfirmReservation() {
    if (brandProfileController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!');
      return;
    }
    print('confirm reservation');
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
      sendInvitations();
    }
  }

  sendInvitations() {
    activeTimer();
    //TODO: add the sending notifation function
    print('sending notificatoin to the selected friends');
  }

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
