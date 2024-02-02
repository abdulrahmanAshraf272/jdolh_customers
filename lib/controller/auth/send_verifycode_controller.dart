import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendVerifycodeController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();

  sendVerifycode() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print('signedUp');
    }
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }
}
