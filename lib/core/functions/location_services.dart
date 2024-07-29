import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  getLocation() async {
    try {
      // Check location permission status
      var status = await Permission.location.status;
      if (status.isDenied) {
        // Request location permission if denied
        status = await Permission.location.request();
        if (status.isDenied) {
          print('Location permission denied. Asking user to enable it.');
          // Show dialog to the user requesting location permission
          Get.defaultDialog(
            title: "غير قادر للوصول لموقعك",
            middleText:
                "من فضلك قم بالسماح للوصول للموقع لتتمكن من تسجيل الوصول",
            //onWillPop: () => getCurrentPosition(),
            textConfirm: 'حسنا',
            onConfirm: () async {
              Get.back();
            },
          );

          return;
        }
      }

      LocationService locationService = LocationService();
      Position position = await locationService.determinePosition();
      print('Current location: ${position.latitude}, ${position.longitude}');
      LatLng latLng = LatLng(position.latitude, position.longitude);
      return latLng;
    } catch (e) {
      print('Failed to get location');
      print('Error: $e');
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  final Geolocator _geolocator = Geolocator();

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> requestLocationPermission() async {
    await Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> requestLocationService() async {
    if (!await isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await checkLocationPermission();
    if (!hasPermission) {
      await requestLocationPermission();
    }

    bool isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await requestLocationService();
    }

    if (hasPermission && isServiceEnabled) {
      try {
        return await Geolocator.getCurrentPosition();
      } catch (e) {
        print("Error getting location: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
