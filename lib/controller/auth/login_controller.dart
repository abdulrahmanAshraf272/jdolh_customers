import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/login.dart';
import 'package:jdolh_customers/data/models/user.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  get formstate => _formstate;
  TextEditingController usernameOrEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  bool passwordVisible = true;
  User user = User();

  login() async {
    var formdata = _formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response =
          await loginData.postData(usernameOrEmail.text, password.text);
      statusRequest = handlingData(response);
      update(); //after status change to display change on the screen.
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          print(' ======== ${response['data']} ======');
          user = User.fromJson(response['data']);
          if (user.userApprove == 1) {
            myServices.setUserData(user);
            myServices.setStep('2');

            goToMainScreen();
          } else {
            goToVerifycode();
          }
        } else {
          if (response['message'] == "The password is not correct") {
            Get.rawSnackbar(message: 'كلمة السر غير صحيحة');
          } else {
            Get.rawSnackbar(
                message: 'اسم المستخدم او البريد الالكتروني غير صحيح');
          }
        }
      }
    }
  }

  goToMainScreen() {
    Get.offAllNamed(AppRouteName.mainScreen);
  }

  goToVerifycode() {
    Get.toNamed(AppRouteName.verifyCode,
        arguments: {"email": usernameOrEmail.text, 'resetPassword': 0});
  }

  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  goToSignUP() {
    Get.offNamed(AppRouteName.signUp);
  }

  goToForgetPassword() {
    if (usernameOrEmail.text.isEmpty) {
      Get.rawSnackbar(message: "من فضلك ادخل الايميل او اسم المستخدم");
    } else {
      Get.toNamed(AppRouteName.forgetPassword,
          arguments: {"email": usernameOrEmail.text, 'resetPassword': 1});
    }
  }

  @override
  void dispose() {
    usernameOrEmail.dispose();
    password.dispose();
    super.dispose();
  }
}
