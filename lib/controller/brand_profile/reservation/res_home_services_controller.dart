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
  TextEditingController city = TextEditingController();
  TextEditingController hood = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController shortAddress = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController apartment = TextEditingController();

  onTapConfirmResHomeService() async {
    if (checkAllFeilds()) {
      CustomDialogs.loading();
      var result = await createRes();
      if (result is Reservation) {
        Reservation reservations = result;
        var addLocationResult = await addResLocation(reservations.resId!);
        CustomDialogs.dissmissLoading();
        if (addLocationResult == true) {
          reservations = injectBrandAndBchDataInReservationsObject(reservation);

          navigateToPaymentOrWaitForApprove();
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
        city: city.text,
        hood: hood.text,
        street: street.text,
        shortAddress: shortAddress.text,
        additionalInfo: additionalInfo.text,
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
    // if (building.text == '') {
    //   Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم او رقم البرج'.tr);
    //   return false;
    // }
    if (city.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم بكتابة اسم المدينة'.tr);
      return false;
    }
    // if (apartment.text == '') {
    //   Get.rawSnackbar(message: 'من فضلك قم بكتابة رقم الشقة'.tr);
    //   return false;
    // }
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
      street.text = placemarks[0].street ?? '';

      hood.text = placemarks[0].subLocality ?? '';
      city.text = placemarks[0].locality ?? '';
      update();
    } else {
      print('no location selected');
    }
  }
}
