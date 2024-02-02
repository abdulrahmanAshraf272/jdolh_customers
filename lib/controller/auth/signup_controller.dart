import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController userID = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool passwordVisible = true;
  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print('signedUp');
    }
  }

  goToLogin() {
    Get.offAllNamed(AppRouteName.login);
  }

  @override
  void dispose() {
    username.dispose();
    userID.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    super.dispose();
  }
}
