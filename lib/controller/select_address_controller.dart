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
import 'package:jdolh_customers/data/data_source/remote/google_maps_sevice.dart';
import 'package:jdolh_customers/data/models/suggestion_place.dart';
import 'package:uuid/uuid.dart';

class SelectAddressController extends GetxController {
  // Arguments //
  bool withBorder = false;
  LatLng? borderLatlng;
  String warningTitle = 'المكان بعيد عنك!';
  String warningBody = 'اذهب الى هناك ثم قم بتسجيل الوصول';
  int maxDistance = RADIUS_LIMIT;
  /////////////

  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest searchStatusRequest = StatusRequest.none;
  StatusRequest placeDetailsStatusRequist = StatusRequest.none;
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

  //TODO: this is for checkin only, what about occation location.
  setMarkAndSaveNewLatLong(LatLng latLong) {
    if (withBorder) {
      bool result = isWithinBorder(latLong);
      if (!result) {
        return;
      }
    }
    marker.clear();
    marker.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(latLong.latitude, latLong.longitude)));
    latLngSelected = latLong;
    print('latidude: ${latLong.latitude},  longitude: ${latLong.longitude}');
    update();
  }

  bool isWithinBorder(LatLng latLngPicked) {
    LatLng locationBorder;
    //if i didn't send border, it means i want to calculate distance between my location and picked location.
    if (borderLatlng != null) {
      locationBorder = borderLatlng!;
    } else {
      locationBorder =
          LatLng(myCurrentLatLng.latitude, myCurrentLatLng.longitude);
    }

    int distanceBetweenMeAndPlaceSelected = calculateDistance(
        locationBorder.latitude,
        locationBorder.longitude,
        latLngPicked.latitude,
        latLngPicked.longitude);
    print('distance: $distanceBetweenMeAndPlaceSelected');

    if (distanceBetweenMeAndPlaceSelected > maxDistance) {
      Get.rawSnackbar(title: warningTitle, message: warningBody);
      return false;
    } else {
      return true;
    }
  }

  onTapSave() {
    if (latLngSelected != null) {
      ValuesController.latLngSelected = latLngSelected;
      Get.back(result: latLngSelected);
    } else {
      Get.rawSnackbar(message: 'قم بتحديد المكان, ثم اضغط حفظ');
    }
  }

  getArgument() {
    if (Get.arguments != null) {
      if (Get.arguments['withBorder'] != null) {
        withBorder = Get.arguments['withBorder'];
        print('withBorder $withBorder');
      }
      if (Get.arguments["borderLatlng"] != null) {
        borderLatlng = Get.arguments["borderLatlng"];
        print('borderLatLng $borderLatlng');
      }
      if (Get.arguments["maxDistance"] != null) {
        maxDistance =
            Get.arguments["maxDistance"] * 1000; //convert from kg to m
        print('maxDistance $maxDistance');
      }
      if (Get.arguments["warningTitle"] != null) {
        warningTitle = Get.arguments["warningTitle"];
      }
      if (Get.arguments["warningBody"] != null) {
        warningBody = Get.arguments["warningBody"];
      }
    }
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

  getPlacesSuggestations(String input) async {
    final sessiontoken = const Uuid().v4();
    searchStatusRequest = StatusRequest.loading;
    update();
    var response = await googleMapsService.getSearchSuggestations(
        country: 'SA',
        lat: myCurrentLatLng.latitude.toString(),
        lng: myCurrentLatLng.longitude.toString(),
        input: input,
        sessiontoken: sessiontoken,
        radius: RADIUS_LIMIT.toString());
    searchStatusRequest = handlingData(response);
    print('status ==== $statusRequest');
    update();
    if (searchStatusRequest == StatusRequest.success) {
      if (response['status'] == 'OK') {
        suggestionPlaces.clear();
        List responseJson = response['predictions'];
        print(responseJson);
        suggestionPlaces =
            responseJson.map((e) => SuggestionPlace.fromJson(e)).toList();
      } else {
        // print('status = ${response['status']}');
        searchStatusRequest = StatusRequest.failure;
      }
    }
  }

  getPlaceDetails(int index) async {
    String placeId = suggestionPlaces[index].placeId!;
    final sessiontoken = const Uuid().v4();

    var response = await googleMapsService.getPlaceDetails(
      placeId: placeId,
      sessiontoken: sessiontoken,
    );
    placeDetailsStatusRequist = handlingData(response);
    print('status ==== $placeDetailsStatusRequist');
    if (placeDetailsStatusRequist == StatusRequest.success) {
      print('status = ${response['status']}');
      if (response['status'] == 'OK') {
        var geometry = response['result']['geometry']['location'];
        latLngSelected = LatLng(geometry['lat'], geometry['lng']);
        print(
            'latLongSelected = ${latLngSelected!.latitude}, ${latLngSelected!.longitude}');
        changeCameraPosition(latLngSelected!);
        setMarkAndSaveNewLatLong(latLngSelected!);
      } else {
        placeDetailsStatusRequist = StatusRequest.failure;
      }
    }
  }

  String extractTitle(int index) {
    String desc = suggestionPlaces[index].description!;
    // Split the description by comma
    List<String> parts = desc.split(',');

    // The title is the first part
    String title = parts[0].trim();

    return title;
  }

  String removeTitle(int index) {
    String desc = suggestionPlaces[index].description!;
    // Split the description by comma
    List<String> parts = desc.split(',');

    // Remove the title (first part)
    parts.removeAt(0);

    // Join the remaining parts back into a string
    String remainingDescription = parts.join(',').trim();

    return remainingDescription;
  }

  @override
  void onInit() {
    super.onInit();
    getArgument();
    ValuesController.latLngSelected = null;
    mapController = Completer<GoogleMapController>();
    goToMyCurrentLocation();
  }
}
