// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentPositionResult {
  String status;
  String? error;
  LatLng? latLng;
  GetCurrentPositionResult({
    required this.status,
    this.error,
    this.latLng,
  });
}

Future<GetCurrentPositionResult> getCurrentPosition() async {
  GetCurrentPositionResult result;
  late bool serviceEnabled;
  LocationPermission? permission;
  Position position;
  //First check: Check if the user is active the gps in his phone.
  // First check: Check if the user has granted location permission to the app.
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      result = GetCurrentPositionResult(status: 'failure', error: 'gps');
      return result;
    } else {
      // Get the current location of the user.
      position = await Geolocator.getCurrentPosition();
      result = GetCurrentPositionResult(
        status: 'success',
        latLng: LatLng(position.latitude, position.longitude),
      );
      return result;
    }
  } else {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      result = GetCurrentPositionResult(status: 'failure', error: 'permission');
      return result;
    } else {
      result = GetCurrentPositionResult(status: 'failure', error: 'permission');
      return result;
    }
  }

  //Second check: Check if the user allow the app to use loaction.
}
