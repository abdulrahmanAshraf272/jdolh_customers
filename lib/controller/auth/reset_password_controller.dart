import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/reset_password.dart';

class ResetPasswordController extends GetxController {
  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  get formstate => _formstate;
  TextEditingController password = TextEditingController();
  TextEditingController checkMatchPassword = TextEditingController();
  bool passwordVisible = true;
  StatusRequest statusRequest = StatusRequest.none;
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  late String email;

  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  resetPassword() async {
    if (_formstate.currentState!.validate()) {
      if (twoFieldMatching()) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await resetPasswordData.postData(email, password.text);
        statusRequest = handlingData(response);
        update();
        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            goToSuccessScreen();
          } else {
            Get.rawSnackbar(message: "حدث خطأ حاول مرة اخرى".tr);
          }
        } //else => will be hendled by HandlingDataView.
      }
    }
  }

  bool twoFieldMatching() {
    if (password.text == checkMatchPassword.text) {
      return true;
    }
    Get.rawSnackbar(message: 'الحقلين غير متطابقين, اعد ادخال كلمة المرور'.tr);
    return false;
  }

  goToSuccessScreen() {
    Get.offNamed(AppRouteName.successOperation,
        arguments: {"resetPassword": true});
  }

  @override
  void dispose() {
    password.dispose();
    checkMatchPassword.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    email = Get.arguments['email'];
    //email = 'talya@gmail.com';
  }
}
