import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/brand_profile/reservation/res_parent_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
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
      statusRequest = StatusRequest.loading;
      update();
      var result = await createRes();
      if (result != null) {
        Reservation res = result as Reservation;
        var addLocationResult = await addResLocation(res.resId!);
        update();
        if (addLocationResult == true) {
          //clear cart beacause it's not null any more , it take the resid = id of res just created.
          //brandProfileController.carts.clear();
          if (homeServices.reviewRes == 0) {
            Get.offNamed(AppRouteName.payment, arguments: result);
          } else {
            Get.offNamed(AppRouteName.waitForApprove, arguments: result);
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
    if (brandProfileController.carts.isEmpty) {
      Get.rawSnackbar(message: 'السلة فارغة!');
      return false;
    }
    if (selectedDate == '') {
      Get.rawSnackbar(message: 'من فضلك اختر وقت الحجز');
      return false;
    }
    if (myLatLng == null || myLocation == '') {
      Get.rawSnackbar(message: 'من فضلك قم بتحديد عنوان المنزل');
      return false;
    }
    if (hood.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم الحي');
      return false;
    }
    if (street.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم الشارع');
      return false;
    }
    if (building.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم او رقم البرج');
      return false;
    }
    if (floor.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة رقم الدور');
      return false;
    }
    if (apartment.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة رقم الشقة');
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
        "warningTitle": 'عذراً',
        "warningBody": 'الخدمة غير متوفرة في هذه المنطقة'
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
