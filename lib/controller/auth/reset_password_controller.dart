import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController checkMatchPassword = TextEditingController();
  bool passwordVisible = true;
  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  resetPassword() {
    if (password.text == checkMatchPassword.text) {
      print(password.text);
    } else {
      Get.rawSnackbar(
          message: 'password in 2 fields not matching, rewrite it.');
    }
  }

  @override
  void dispose() {
    password.dispose();
    checkMatchPassword.dispose();
    super.dispose();
  }
}
