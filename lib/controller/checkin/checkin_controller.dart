import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/calculate_distance.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/location_services.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/checkin.dart';
import 'package:jdolh_customers/data/models/place.dart';

class CheckinController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  CheckinData checkinData = CheckinData(Get.find());
  List<Place> googlePlaces = [];
  List<Place> jdolhPlaces = [];
  List<Place> allPlaces = [];
  bool isGetCurrentLocationSuccess = true;
  ValuesController valuesController = Get.put(ValuesController());
  //late LatLng myCurrentPosition;
  MyServices myServices = Get.find();

  LatLng? latLng;

  getAllPlaces() async {
    if (latLng != null) {
      await getGooglePlaces(latLng!);
      getJdolhPlaces(latLng!);
    }
  }

  getGooglePlaces(LatLng latLng) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await checkinData.getGooglePlaces(
      //lat: '31.2624446',
      //lng: '29.9877722',
      lat: latLng.latitude.toString(),
      lng: latLng.longitude.toString(),
      radius: RADIUS_LIMIT.toString(),
      //keywords: 'restaurant',
    );
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      //print(responseJsonList);
      print(response);
      if (response['status'] == 'OK') {
        List responseJsonList = response['results'];
        googlePlaces =
            responseJsonList.map((e) => Place.fromJsonGoogle(e)).toList();
        allPlaces.addAll(googlePlaces);
      } else {
        print(response['error_message']);
      }
    }
  }

  getJdolhPlaces(LatLng latLng) async {
    var response = await checkinData.getJdolhPlaces();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseJsonList = response['data'];
        print('getting jdolh places is done successfuly');
        jdolhPlaces =
            responseJsonList.map((e) => Place.fromJsonJdolh(e)).toList();

        //Displace places form DB only nearby to me.
        for (int i = 0; i < jdolhPlaces.length; i++) {
          int distanceBetweenMeAndPlaceSelected = calculateDistance(
              jdolhPlaces[i].lat ?? 0,
              jdolhPlaces[i].lng ?? 0,
              latLng.latitude,
              latLng.longitude);
          if (distanceBetweenMeAndPlaceSelected < 500) {
            allPlaces.add(jdolhPlaces[i]);
          }
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  onTapCard(Place place) async {
    Get.toNamed(AppRouteName.checkinConfirm, arguments: place);
  }

  // handleGetCurrentPositionResult() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   GetCurrentPositionResult result = await getCurrentPosition();
  //   if (result.status == 'success') {
  //     isGetCurrentLocationSuccess = true;
  //     getAllPlaces(result.latLng!);
  //     update();
  //   } else {
  //     statusRequest = StatusRequest.unableToGetLocation;
  //     update();
  //     isGetCurrentLocationSuccess = false;
  //     result.error == 'gps' ? activeGpsAlert() : activePermissionAlert();
  //   }
  // }

  getLocation() async {
    print('start get the location');
    LocationService locationService = LocationService();

    var result = await locationService.getLocation();
    if (result != null) {
      valuesController.currentPosition = result;
      latLng = result;
    }
    getAllPlaces();
    // Get.defaultDialog(
    //   title: "غير قادر للوصول لموقعك",
    //   middleText: "من فضلك قم بالسماح للوصول للموقع لتتمكن من تسجيل الوصول",
    //   //onWillPop: () => getCurrentPosition(),
    //   textConfirm: 'حسنا',
    //   onConfirm: () async {
    //     Get.back();

    //   },
    // );
  }

  // _getCurrentLocation() async {
  //   try {
  //     LocationService locationService = LocationService();
  //     Position position = await locationService.determinePosition();
  //     valuesController.currentPosition =
  //         LatLng(position.latitude, position.longitude);
  //     latLng = LatLng(position.latitude, position.longitude);

  //     print('Current location: ${position.latitude}, ${position.longitude}');
  //   } catch (e) {
  //     print('failed to get location');
  //     print('Error: $e');
  //   }
  // }

  goToAddNewPlace() {
    Get.toNamed(AppRouteName.addNewPlace);
  }

  @override
  void onInit() async {
    super.onInit();

    if (valuesController.currentPosition != null) {
      print('valuecontroller location is null');
      latLng = valuesController.currentPosition!;
      getAllPlaces();
    } else {
      getLocation();
    }
  }
}
