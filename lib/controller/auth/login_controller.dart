import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = true;

  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print('signedUp');
    }
  }

  goToSignUP() {
    Get.offAllNamed(AppRouteName.signUp);
  }

  goToForgetPassword() {}

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
