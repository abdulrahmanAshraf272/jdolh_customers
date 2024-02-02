import 'dart:async';

import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';

class VerifycodeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  late String verifycode;
  late Timer timer;
  RxInt remainingSeconds = 10.obs;

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        timer.cancel();
        //timer = null;
        timerFinished(); // Call your function here
      }
    });
  }

  timerFinished() {
    print('====== Timer Finished');
  }

  checkVerifyIsCorrect() {
    print(verifycode);
  }

  resendVerifycode() {
    Get.snackbar('Resend Done!', 'go check your email.');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _startTimer();
  }
}
