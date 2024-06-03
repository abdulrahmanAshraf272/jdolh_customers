import 'dart:async';

import 'package:get/get.dart';

class ReservationConfirmWaitController extends GetxController {
  //Timer variables
  bool timerIsActive = false;
  late Timer timer;
  int minutesTimeAllowedToConfirmReservation = 1800;
  late int remainingTime;
  late RxInt remainingMin;
  late RxInt remainingSec;
  //String buttonText = textConfirmReservation;

//Timer functions
  // confirmReservation() {
  //   print('confirm reservation and going to pay secreen');
  //   Get.toNamed(AppRouteName.payment);
  //   inactiveTimer();
  // }

  // activeTimer() {
  //   timerIsActive = true;
  //   _startTimer();
  //   buttonText = textConfirmReservation;
  //   update();
  // }

  inactiveTimer() {
    if (timerIsActive) {
      timerIsActive = false;
      timer.cancel();
    }

    // buttonText = textConfirmReservation;
    update();
  }

  // activeWithInvitationOption() {
  //   withInvitation = true;
  //   buttonText = textSendInvication;
  //   update();
  // }

  // activeNoInvitationOption() {
  //   withInvitation = false;
  //   inactiveTimer();
  // }

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
}
