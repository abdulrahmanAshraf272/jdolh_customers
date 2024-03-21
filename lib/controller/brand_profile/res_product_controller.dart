import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'dart:async';

import 'package:jdolh_customers/core/constants/strings.dart';

class BrandProfileController extends GetxController {
  //Checker variables
  bool withInvitation = false;
  bool timerIsActive = false;
  int activeSubScreen = 2;

  //Timer variables
  late Timer timer;
  int minutesTimeAllowedToConfirmReservation = 1800;
  late int remainingTime;
  late RxInt remainingMin;
  late RxInt remainingSec;

  String buttonText = textConfirmReservation;

  subScreenSwitch() {
    if (activeSubScreen == 1) {
      activeSubScreen = 2;
    } else {
      activeSubScreen = 1;
    }
    update();
  }

  // displayProductSubScreen() {
  //   activeSubScreen = 1;
  //   update();
  // }
  // displayReservationSubScreen() {
  //   activeSubScreen = 2;
  //   update();
  // }
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
    remainingTime = (minutesTimeAllowedToConfirmReservation * 60);
    remainingMin = (remainingTime ~/ 60).obs;
    remainingSec = (remainingTime % 60).obs;
  }
}
