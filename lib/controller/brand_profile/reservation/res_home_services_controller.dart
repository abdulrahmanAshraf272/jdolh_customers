import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ResHomeServicesController extends ResParentController {
  //ValuesController valuesController = Get.put(ValuesController());
  LatLng? myLatLng;
  String myLocation = '';
  TextEditingController hood = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController apartment = TextEditingController();

  onTapConfirmRes() async {
    if (checkAllFeilds()) {
      CustomDialogs.loading();
      var result = await createRes();
      if (result is Reservation) {
        Reservation res = result;
        var addLocationResult = await addResLocation(res.resId!);
        CustomDialogs.dissmissLoading();
        if (addLocationResult == true) {
          //clear cart beacause it's not null any more , it take the resid = id of res just created.
          //brandProfileController.carts.clear();
          print('location: ${brandProfileController.bch.bchLat}');
          print('lat: ${brandProfileController.bch.bchLat}');
          print('lng: ${brandProfileController.bch.bchLng}');
          res.bchLocation = brandProfileController.bch.bchLocation;
          res.bchLat = brandProfileController.bch.bchLat;
          res.bchLng = brandProfileController.bch.bchLng;

          if (homeServices.reviewRes == 0) {
            Get.offNamed(AppRouteName.payment, arguments: {
              "res": res,
              "resPolicy": brandProfileController.resPolicy,
              "billPolicy": brandProfileController.billPolicy,
              "brand": brandProfileController.brand
            });
          } else {
            Get.offNamed(AppRouteName.waitForApprove, arguments: {
              "res": res,
              "resPolicy": brandProfileController.resPolicy,
              "billPolicy": brandProfileController.billPolicy,
              "brand": brandProfileController.brand
            });
          }
        }
      }
    }
  }

  addResLocation(int resid) async {
    var response = await resData.addResLocation(
        userid: myServices.getUserid(),
        resid: resid.toString(),
        lat: myLatLng!.latitude.toString(),
        lng: myLatLng!.longitude.toString(),
        location: myLocation,
        hood: hood.text,
        street: hood.text,
        building: building.text,
        floor: floor.text,
        apartment: apartment.text);
    statusRequest = handlingData(response);
    print('add res location $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        return true;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  bool checkAllFeilds() {
    if (cartController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!'.tr);
      return false;
    }
    if (selectedDate == '') {
      Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز'.tr);
      return false;
    }
    if (myLatLng == null || myLocation == '') {
      Get.rawSnackbar(message: 'من فضلك قم بتحديد عنوان المنزل'.tr);
      return false;
    }
    if (hood.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم الحي'.tr);
      return false;
    }
    if (street.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم الشارع'.tr);
      return false;
    }
    if (building.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم او رقم البرج'.tr);
      return false;
    }
    if (floor.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة رقم الدور'.tr);
      return false;
    }
    if (apartment.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة رقم الشقة'.tr);
      return false;
    }
    return true;
  }

  goToAddLocation() async {
    var result;
    if (homeServices.maxDistance == 0 || homeServices.maxDistance == null) {
      //if there is no border.
      result = await Get.toNamed(AppRouteName.selectAddressScreen);
    } else {
      LatLng bchLatlng = LatLng(
          double.parse(brandProfileController.bch.bchLat!),
          double.parse(brandProfileController.bch.bchLng!));
      result = await Get.toNamed(AppRouteName.selectAddressScreen, arguments: {
        "withBorder": true,
        "borderLatlng": bchLatlng,
        "maxDistance": homeServices.maxDistance,
        "warningTitle": 'عذراً'.tr,
        "warningBody": 'الخدمة غير متوفرة في هذه المنطقة'.tr
      });
    }

    if (result != null) {
      myLatLng = result as LatLng;
      print('selectedLocation ===> $myLatLng');
      List<Placemark> placemarks = await placemarkFromCoordinates(
          myLatLng!.latitude, myLatLng!.longitude);
      myLocation =
          '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}';
      print('myLocation ====> $myLocation');
      update();
    } else {
      print('no location selected');
    }
  }
}
