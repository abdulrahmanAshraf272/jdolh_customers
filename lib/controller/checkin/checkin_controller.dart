import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/dialogs.dart';
import 'package:jdolh_customers/core/functions/get_current_position.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/checkin.dart';
import 'package:jdolh_customers/data/models/place.dart';

class CheckinController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  CheckinData checkinData = CheckinData(Get.find());
  List<Place> googlePlaces = [];
  bool isGetCurrentLocationSuccess = true;
  ValuesController valuesController = Get.put(ValuesController());
  late LatLng myCurrentPosition;
  MyServices myServices = Get.find();

  getGooglePlaces(LatLng latLng) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await checkinData.getGooglePlaces(
      lat: '31.2624446',
      lng: '29.9877722',
      // lat: latLng.latitude.toString(),
      // lng: latLng.longitude.toString(),
      radius: '500',
      //keywords: 'restaurant',
    );
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      List responseJsonList = response['results'];
      print(responseJsonList);
      googlePlaces =
          responseJsonList.map((e) => Place.fromJsonGoogle(e)).toList();
    }
    update();
  }

  onTapCard(Place place) async {
    Get.toNamed(AppRouteName.checkinConfirm, arguments: place);
  }

  handleGetCurrentPositionResult() async {
    statusRequest = StatusRequest.loading;
    update();
    GetCurrentPositionResult result = await getCurrentPosition();
    if (result.status == 'success') {
      isGetCurrentLocationSuccess = true;
      getGooglePlaces(result.latLng!);
      update();
    } else {
      statusRequest = StatusRequest.unableToGetLocation;
      update();
      isGetCurrentLocationSuccess = false;
      result.error == 'gps' ? activeGpsAlert() : activePermissionAlert();
    }
  }

  @override
  void onInit() async {
    super.onInit();

    if (valuesController.currentPosition != null) {
      myCurrentPosition = valuesController.currentPosition!;
      getGooglePlaces(myCurrentPosition);
    } else {
      handleGetCurrentPositionResult();
    }
  }
}
