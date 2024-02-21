import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/bill.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/comment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/group.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/wallet_operation.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_customers/view/widgets/common/flexable_toggle_button.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  StatusRequest statusRequest = StatusRequest.loading;
  late bool serviceEnabled;
  LocationPermission? permission;
  late double lat;
  late double long;
  late Position position;
  List<Marker> marker = [];

  late Completer<GoogleMapController> mapController;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12,
  );

  @override
  getCurrentPosition() async {
    //First check: Check if the user is active the gps in his phone.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      openGpsAlert();
      return;
    }
    //Second check: Check if the user allow the app to use loaction.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        allowToUseLocationAlert();
        return;
      }
    }
    //Get the currrent loction of the user.
    position = await Geolocator.getCurrentPosition();
    lat = position.latitude;
    long = position.longitude;
    print('latidude: $lat,  longitude: $long');

    cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 12,
    );
    //Add marker to the map in the current location.
    marker.add(
        Marker(markerId: const MarkerId("1"), position: LatLng(lat, long)));
    statusRequest = StatusRequest.success;
    setState(() {});
  }

  openGpsAlert() {
    Get.defaultDialog(
        title: "Warning",
        middleText: "Active GPS in your phone please",
        onWillPop: () => getCurrentPosition(),
        confirm: const Text('Ok'),
        onConfirm: () => getCurrentPosition());
  }

  allowToUseLocationAlert() {
    Get.defaultDialog(
        title: "Warning",
        middleText: "You should allow use location to continue.",
        onWillPop: () => getCurrentPosition(),
        confirm: const Text('Ok'),
        onConfirm: () => getCurrentPosition());
  }

  mapOnTap(LatLng latLong) {
    lat = latLong.latitude;
    long = latLong.longitude;
    marker.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(latLong.latitude, latLong.longitude)));
    print('latidude: $lat,  longitude: $long');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'وقت الحجز'),
      body: Column(
        children: [
          Expanded(
              child: GoogleMap(
            mapType: MapType.normal,
            markers: marker.toSet(),
            onTap: (latLong) {
              mapOnTap(latLong);
            },
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController mController) {
              mapController.complete(mController);
            },
          ))
        ],
      ),
    );
  }
}
