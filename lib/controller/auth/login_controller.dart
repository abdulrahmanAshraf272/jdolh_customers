import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_subscribtion.dart';
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
      CustomDialogs.loading();
      var response =
          await loginData.postData(usernameOrEmail.text, password.text);
      await Future.delayed(Duration(seconds: lateDuration));
      CustomDialogs.dissmissLoading();
      statusRequest = handlingData(response);
      print('status: $statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          print(' ======== ${response['data']} ======');
          user = User.fromJson(response['data']);
          if (user.userApprove == 1) {
            myServices.setUserData(user);

            NotificationSubscribtion.userSubscribeToTopic(
                user.userId, user.userCity, user.userGender);

            myServices.setStep('2');

            goToMainScreen();
          } else {
            goToVerifycode();
          }
        } else {
          if (response['message'] == "The password is not correct") {
            Get.rawSnackbar(message: 'كلمة السر غير صحيحة'.tr);
          } else {
            Get.rawSnackbar(
                message: 'اسم المستخدم او البريد الالكتروني غير صحيح'.tr);
          }
        }
      } else {
        update();
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
      Get.rawSnackbar(message: "من فضلك ادخل الايميل او اسم المستخدم".tr);
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
