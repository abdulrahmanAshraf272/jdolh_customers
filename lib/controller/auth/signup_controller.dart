import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/signup.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  get formstate => _formstate;
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  SignupData signupData = SignupData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
  bool passwordVisible = true;
  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await signupData.postData(name.text, username.text,
          password.text, email.text, phoneNumber.text, "0", "");
      statusRequest = handlingData(response);
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          goToVerifycode();
          // Get.bottomSheet(Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //   height: Get.height * 0.4,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(20),
          //           topRight: Radius.circular(20)),
          //       color: Colors.white,
          //       boxShadow: [boxShadow1]),
          //   child: Column(
          //     children: [
          //       Text('سوف يتم ارسال رمز التأكيد عبر الواتساب',
          //           style: titleMedium),
          //       SizedBox(height: 20),
          //       GoHomeButton(text: 'حسنا', onTap: () => goToVerifycode())
          //     ],
          //   ),
          // ));
        } else if (response['message'] == 'username exist') {
          Get.defaultDialog(
            title: 'تنبيه',
            middleText: "اسم المستخدم مستعمل, من فضلك اختر اسم اخر",
            textCancel: 'حسنا',
          );
        } else if (response['message'] == "phone exist") {
          Get.defaultDialog(
              title: 'تنبيه',
              middleText: "الحساب موجود بالفعل,قم بتسجيل الدخول",
              textCancel: 'الغاء',
              textConfirm: 'حسنا',
              onConfirm: () => goToLogin());
        } else if (response['message'] == "email exist") {
          Get.defaultDialog(
              title: 'تنبيه',
              middleText: "الحساب موجود بالفعل,قم بتسجيل الدخول",
              textCancel: 'الغاء',
              textConfirm: 'حسنا',
              onConfirm: () => goToLogin());
        }
      } //else => will be hendled by HandlingDataView.
    }
  }

  goToLogin() {
    Get.offAllNamed(AppRouteName.login);
  }

  goToVerifycode() {
    Get.offNamed(AppRouteName.verifyCode,
        arguments: {"email": email.text, 'resetPassword': 0});
  }

  @override
  void dispose() {
    name.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    super.dispose();
  }
}
