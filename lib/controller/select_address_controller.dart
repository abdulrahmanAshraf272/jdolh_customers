import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/calculate_distance.dart';
import 'package:jdolh_customers/core/functions/location_services.dart';

class SelectAddressController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  List<Marker> marker = [];
  final LocationService locationService = LocationService();
  late Completer<GoogleMapController> mapController;
  ValuesController valuesController = ValuesController();
  late LatLng myCurrentLatLng;
  LatLng? latLngSelected;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(21.257808, 39.817766),
    zoom: CAMERA_ZOOM,
  );

  goToMyCurrentLocation() async {
    if (valuesController.currentPosition != null) {
      myCurrentLatLng = LatLng(valuesController.currentPosition!.latitude,
          valuesController.currentPosition!.longitude);
      changeCameraPosition(myCurrentLatLng);
    } else {
      Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        print(
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
        valuesController.currentPosition =
            LatLng(position.latitude, position.longitude);
        myCurrentLatLng = LatLng(valuesController.currentPosition!.latitude,
            valuesController.currentPosition!.longitude);
        changeCameraPosition(myCurrentLatLng);
      } else {
        allowToUseLocationAlert();
        print('Failed to get location');
      }
    }
    statusRequest = StatusRequest.success;
    update();
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
    int distanceBetweenMeAndPlaceSelected = calculateDistance(
        myCurrentLatLng.latitude,
        myCurrentLatLng.longitude,
        latLong.latitude,
        latLong.longitude);
    print('%%%%%%%%%%%%%%%%');
    print('the distance is = $distanceBetweenMeAndPlaceSelected');
    if (distanceBetweenMeAndPlaceSelected > 500) {
      Get.rawSnackbar(
          title: 'المكان بعيد عنك!',
          message: 'اذهب الى هناك ثم قم بتسجيل الوصول');
      return;
    }
    marker.clear();
    marker.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(latLong.latitude, latLong.longitude)));
    latLngSelected = latLong;
    print('latidude: ${latLong.latitude},  longitude: ${latLong.longitude}');
    update();
  }

  allowToUseLocationAlert() {
    Get.defaultDialog(
      title: "تحذير",
      middleText:
          "من فضلك فعل امكانية الوصول والموقع والGPS لتجربة استخدام افضل",
      //onWillPop: () => getCurrentPosition(),
      textConfirm: 'حسنا',
      onConfirm: () async {
        Get.back();
        Position? position = await locationService.getCurrentLocation();
        if (position != null) {
          print(
              'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
          valuesController.currentPosition =
              LatLng(position.latitude, position.longitude);
        } else {
          print('Failed to get location');
        }
      },
    );
  }

  onTapSave() {
    if (latLngSelected != null) {
      ValuesController.latLngSelected = latLngSelected;
      print('======================');
      print(latLngSelected!.latitude);
      print(ValuesController.latLngSelected!.longitude);
      Get.back();
    } else {
      Get.rawSnackbar(message: 'قم بتحديد المكان, ثم اضغط حفظ');
    }
  }

  @override
  void onInit() {
    super.onInit();
    ValuesController.latLngSelected = null;
    mapController = Completer<GoogleMapController>();
    goToMyCurrentLocation();
  }
}
