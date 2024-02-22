import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/data/models/place.dart';

class AddNewPlaceController extends GetxController {
  TextEditingController placeName = TextEditingController();
  String placeLocation = '';
  String placeType = '---';
  double? lat;
  double? lng;
  bool placeFromCoordinateDone = false;

  goToAddLocation() {
    // Get.toNamed(AppRouteName.addOccasionLocation)!.then((value) => print(
    //     'lat: ${latLngSelected!.latitude}, long: ${latLngSelected!.latitude}'));
    Get.toNamed(AppRouteName.selectAddressScreen)!.then((value) async {
      if (ValuesController.latLngSelected != null) {
        lat = ValuesController.latLngSelected!.latitude;
        lng = ValuesController.latLngSelected!.longitude;

        List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
        placeLocation =
            '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}';
        placeFromCoordinateDone = true;
        update();
      } else {
        print('no location selected');
      }
    });
  }

  onTapConfirm() {
    if (placeFromCoordinateDone = false) {
      return;
    }
    if (placeName.text == '') {
      Get.rawSnackbar(message: 'قم باضافة اسم المكان');
      return;
    }
    if (placeLocation == '' || lat == null || lng == null) {
      Get.rawSnackbar(message: 'قم باضافة موقع المكان');
      return;
    }
    if (placeType == '---') {
      Get.rawSnackbar(message: 'قم باضافة نوع المكان');
      return;
    }

    Place place = Place(
        placeId: '',
        name: placeName.text,
        location: placeLocation,
        lat: lat,
        lng: lng,
        type: placeType);
    Get.toNamed(AppRouteName.checkinConfirm, arguments: place);
  }
}
