import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/pick_image.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/signup.dart';
import 'package:jdolh_customers/data/models/user.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';

class SignUpController extends GetxController {
  File? image;
  Uint8List? selectedImage;
  String city = cities[0];

  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  get formstate => _formstate;
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneNumber2 = TextEditingController();
  String countryKey = '';
  SignupData signupData = SignupData(Get.find());
  int gender = 1;
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  bool passwordVisible = true;
  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  uploadImage() async {
    XFile? xFile = await pickImageFromGallery();

    if (xFile != null) {
      image = File(xFile.path);
      selectedImage = await xFile.readAsBytes();
      update();
    } else {
      print("User canceled image picking");
      // Handle the case where the user canceled image picking
    }
  }

  signUp() async {
    if (phoneNumber2.text == '') {
      return Get.rawSnackbar(message: 'من فضلك ادخل رقم الجوال');
    }
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print('sign up');
      print('$countryKey${phoneNumber2.text}');
      statusRequest = StatusRequest.loading;
      update();
      var response = await signupData.postData(
          name.text,
          username.text,
          password.text,
          email.text,
          '$countryKey ${phoneNumber2.text}',
          gender.toString(),
          city,
          image);
      statusRequest = handlingData(response);
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          User user = User.fromJson(response['data']);
          myServices.setUserData(user);
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
    phoneNumber2.dispose();
    super.dispose();
  }
}
