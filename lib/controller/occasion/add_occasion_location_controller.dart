import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/group/create_group_controller.dart';
import 'package:jdolh_customers/controller/occasion/create_occasion_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/get_current_position.dart';

class AddOccasionLocationController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  late bool serviceEnabled;
  LocationPermission? permission;
  // double? lat;
  // double? long;
  CreateOccasionController createOccasionController =
      Get.put(CreateOccasionController());
  // double? myCurrentLat;
  // double? myCurrentLong;

  LatLng? latLngSelected;
  LatLng? myCurrentLatLng;
  late Position position;
  List<Marker> marker = [];

  late Completer<GoogleMapController> mapController;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: CAMERA_ZOOM,
  );

  getCurrentPosition() async {
    //First check: Check if the user is active the gps in his phone.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      openGpsAlert();
      return false;
    }
    //Second check: Check if the user allow the app to use loaction.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        allowToUseLocationAlert();
        return false;
      }
    }
    //Get the currrent loction of the user.
    position = await Geolocator.getCurrentPosition();
    myCurrentLatLng = LatLng(position.latitude, position.longitude);

    //initailly set camera
    print(
        'latidude: ${myCurrentLatLng!.latitude},  longitude: ${myCurrentLatLng!.longitude}');
    cameraPosition = CameraPosition(
      target: myCurrentLatLng!,
      zoom: CAMERA_ZOOM,
    );
    //Add marker to the map in the current location.
    // marker.add(
    //     Marker(markerId: const MarkerId("1"), position: LatLng(lat, long)));

    statusRequest = StatusRequest.success;
    update();
    return true;
  }

  openGooleMaps() async {
    bool getCurrentLocasionAvailable = await getCurrentPosition();
    if (!getCurrentLocasionAvailable) {
      statusRequest = StatusRequest.success;
      update();
    }
  }

  openGpsAlert() {
    Get.defaultDialog(
        title: "الGPS غير مفعل",
        middleText: "فعل الgps لتجربة استخدام افضل",
        //onWillPop: () => getCurrentPosition(),
        textConfirm: 'قمت بالتفعيل',
        onConfirm: () => getCurrentPosition(),
        textCancel: "الغاء",
        onCancel: () {});
  }

  allowToUseLocationAlert() {
    Get.defaultDialog(
        title: "تحذير",
        middleText: "يجب عليك تفعيل اماكنية الوصل للموقع لتجربة استخدام افضل",
        //onWillPop: () => getCurrentPosition(),
        textConfirm: 'حسنا',
        onConfirm: () => getCurrentPosition());
  }

  goToMyCurrentLocation() async {
    if (myCurrentLatLng != null) {
      changeCameraPosition(myCurrentLatLng!);
    } else {
      Get.rawSnackbar(message: 'من فضلك فعل امكانية الوصول للموقع');
    }
  }

  changeCameraPosition(LatLng latLng) async {
    final GoogleMapController newMapController = await mapController.future;
    cameraPosition = CameraPosition(
      target: latLng,
      zoom: 18,
    );
    newMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  setMarkAndSaveNewLatLong(LatLng latLong) {
    marker.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(latLong.latitude, latLong.longitude)));
    latLngSelected = latLong;
    print('latidude: ${latLong.latitude},  longitude: ${latLong.longitude}');
    update();
  }

  onTapSave() {
    createOccasionController.latLngSelected = latLngSelected;
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    mapController = Completer<GoogleMapController>();
    // getCurrentPosition();
    openGooleMaps();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
