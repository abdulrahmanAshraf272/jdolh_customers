import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/data/models/resOption.dart';

class ResServiceConltroller extends GetxController {
  List<ResOption> resOptions = [];
  List<String> resOptionsTitles = [];
  late ResOption selectedResOption;
  selectResOption(String resOptionTitle) {
    selectedResOption = resOptions
        .firstWhere((element) => element.resoptionsTitle == resOptionTitle);
  }

  String totalServiceDuration = '-';

  calcResTotalDuration() {
    if (brandProfileController.carts.isEmpty) {
      totalServiceDuration = '-';
    } else {
      int totalDuration = 0;
      brandProfileController.carts.forEach((element) {
        totalDuration += element.itemsDuration ?? 0;
      });
      totalServiceDuration = totalDuration.toString();
    }
    update();
  }

  BrandProfileController brandProfileController = Get.find();

  String selectedResDateTime = '';

  void gotoSetResTime() async {
    if (brandProfileController.carts.isEmpty) {
      String message = brandProfileController.brand.brandIsService == 1
          ? 'من فضلك قم بإضافة الخدمات ثم قم بتحديد وقت الحجز'
          : 'من فضلك قم بإضافة المنتجات ثم قم بتحديد وقت الحجز';
      Get.rawSnackbar(message: message);
      return;
    }
    final result = await Get.toNamed(AppRouteName.setResTime);
    if (result != null) {
      selectedResDateTime = result;
      print(selectedResDateTime);
      update();
    }
  }

  checkAllItemsAvailableWithinResOptionSelected() {
    List<dynamic> resItemsId = selectedResOption.itemsRelated!;
    for (int i = 0; i < brandProfileController.carts.length; i++) {
      if (!resItemsId.contains(brandProfileController.carts[i].itemsId)) {
        String warningMessage =
            '${brandProfileController.carts[i].itemsTitle} غير متوفر ضمن تفضيل ${selectedResOption.resoptionsTitle}\n قم بإزالة ${brandProfileController.carts[i].itemsTitle} او قم بتغيير التفضيل';
        print(warningMessage);
        return warningMessage;
      }
    }
    return true;
  }

  onTapConfirmReservation() {
    if (brandProfileController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!');
      return;
    }
    print('confirm reservation');
  }

  @override
  void onInit() {
    //Get ResOption
    resOptions = List.from(brandProfileController.resOptions);
    resOptionsTitles = List.from(brandProfileController.resOptionsTitles);
    selectedResOption = brandProfileController.selectedResOption;
    super.onInit();
  }
}
