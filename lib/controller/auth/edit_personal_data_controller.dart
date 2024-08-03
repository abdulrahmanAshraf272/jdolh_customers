import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/pick_image.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/signup.dart';
import 'package:jdolh_customers/data/models/user.dart';

class EditPersonalDataController extends GetxController {
  File? image;
  String networkImage = '';
  Uint8List? selectedImage;
  MyServices myServices = Get.find();
  String city = cities[0];

  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  get formstate => _formstate;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  //TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String countryKey = '+966';
  SignupData signupData = SignupData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
  int gender = 1;

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

  editPersonalData() async {
    if (phoneNumber.text == '') {
      return Get.rawSnackbar(message: 'من فضلك ادخل رقم الجوال');
    }
    print('$countryKey ${phoneNumber.text}');
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      CustomDialogs.loading();
      var response = await signupData.editPersonalData(
          userid: myServices.getUserid(),
          name: '${firstName.text} ${lastName.text}',
          username: username.text,
          email: email.text,
          phone: '$countryKey ${phoneNumber.text}',
          gender: gender.toString(),
          city: city,
          file: image);
      CustomDialogs.dissmissLoading();
      statusRequest = handlingData(response);
      print('status $statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        print('response ${response['status']}');
        if (response['status'] == 'success') {
          User user = User.fromJson(response['data']);
          myServices.setUserData(user);
          CustomDialogs.success('تم تعديل البيانات'.tr);
          //Get.back();
          Get.offNamed(AppRouteName.mainScreen, arguments: {'page': 3});
        } else if (response['message'] == 'username exist') {
          Get.defaultDialog(
            title: 'تنبيه'.tr,
            middleText: "اسم المستخدم مستعمل, من فضلك اختر اسم اخر".tr,
            textCancel: 'حسنا'.tr,
          );
        } else if (response['message'] == "phone exist") {
          Get.defaultDialog(
            title: 'تنبيه'.tr,
            middleText: "الحساب موجود بالفعل".tr,
            textCancel: 'الغاء'.tr,
          );
        } else if (response['message'] == "email exist") {
          Get.defaultDialog(
            title: 'تنبيه'.tr,
            middleText: "الحساب موجود بالفعل".tr,
          );
        } else {
          Get.back();
        }
      }
    }
  }

  getUser() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await signupData.getUser(myServices.getUserid());
    statusRequest = handlingData(response);
    print('status: $statusRequest');
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        User user = User.fromJson(response['data']);
        setAllData(user);
        print('name : ${user.userName}');
      } else {
        print('failure');
      }
    }
    update();
  }

  setAllData(User user) {
    //Get fullName from sharedPrefs and get from it first and last name;
    String fullName = user.userName ?? '';
    List<String> nameParts = fullName.split(' ');
    firstName.text = nameParts[0];
    lastName.text = nameParts[1];

    username.text = user.userUsername ?? '';
    email.text = user.userEmail ?? '';
    String phoneWithKey = user.userPhone ?? '';
    phoneNumber.text = phoneWithKey.replaceAll(RegExp(r'^\+\d+\s*'), '');
    city = user.userCity ?? '';
    gender = user.userGender ?? 1;
    print('gender: $gender');
    networkImage = user.image ?? '';
    print(networkImage);
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    super.dispose();
  }
}
