import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/calculate_distance.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/location_services.dart';
import 'package:jdolh_customers/data/data_source/remote/auth/google_maps_sevice.dart';
import 'package:jdolh_customers/data/models/suggestion_place.dart';
import 'package:uuid/uuid.dart';

class DisplayLocationController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  GoogleMapsService googleMapsService = GoogleMapsService(Get.find());
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

  List<SuggestionPlace> suggestionPlaces = [];

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

  setMarkAndCamerDisplayGivenLocation(LatLng latLng) {
    marker.add(Marker(markerId: const MarkerId("1"), position: latLng));
    changeCameraPosition(latLng);
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    mapController = Completer<GoogleMapController>();
    LatLng latLng = Get.arguments;
    setMarkAndCamerDisplayGivenLocation(latLng);
  }
}
