import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/location_services.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/my_profile.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/screens/appt_details_screen.dart';
import 'package:jdolh_customers/view/screens/appt_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/create_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/more_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/occasions_screen.dart';
import 'package:jdolh_customers/view/screens/res_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/reservation_search_screen.dart';
import 'package:jdolh_customers/view/screens/schedule/schedule_screen.dart';

class MainController extends GetxController {
  // late bool serviceEnabled;
  // LocationPermission? permission;
  final LocationService locationService = LocationService();
  late Position position;
  StatusRequest statusRequest = StatusRequest.none;
  MyProfileData myProfileData = MyProfileData(Get.find());
  MyServices myServices = Get.find();
  ValuesController valuesController = Get.put(ValuesController());
  List<Friend> myfollowers = [];
  List<Friend> myfollowing = [];
  // List<Occasion> myOccasions = [];
  // List<Occasion> acceptedOccasions = [];
  // List<Occasion> suspendedOccasions = [];
  int currentPage = 0;
  List<Widget> listPage = [
    const HomeScreen(),
    const ResOccasionScreen(),
    const ReservationSearchScreen(),
    const MoreScreen()
  ];
  @override
  changePage(int i) {
    currentPage = i;
    update();
  }

  getMyProfileData() async {
    startLoadingAndClearLists();
    var response = await myProfileData
        .postData(myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        //parsing jsonList to DartList.
        parsingDataFromJsonToDartList(response);
        print('MyfollowersNo: ${myfollowers.length}');
        print('MyfollowingNo: ${myfollowing.length}');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parsingDataFromJsonToDartList(response) {
    List responseFollowers = response['followers'];
    List responseFollowing = response['following'];
    //List responseOccasoins = response['occasions'];
    myfollowers = responseFollowers.map((e) => Friend.fromJson(e)).toList();
    myfollowing = responseFollowing.map((e) => Friend.fromJson(e)).toList();

    //myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();
    // //make acceptedOccasionList and suspended list
    // for (var element in myOccasions) {
    //   if (element.acceptstatus == 1) {
    //     acceptedOccasions.add(element);
    //   } else {
    //     suspendedOccasions.add(element);
    //   }
    // }

    //Save Date in ValuesController
    //valuesController.myOccasions = List.from(myOccasions);
    // valuesController.resetAcceptedAndSuspendedList();
    valuesController.myfollowing = List.from(myfollowing);
    valuesController.myfollowers = List.from(myfollowers);
    //Get value from ValuesController after done operation
    //acceptedOccasions = List.from(valuesController.acceptedOccasions);
    // suspendedOccasions = List.from(valuesController.suspendedOccasions);
  }

  startLoadingAndClearLists() {
    statusRequest = StatusRequest.loading;
    update();
    myfollowers.clear();
    myfollowing.clear();
    //myOccasions.clear();
  }

  goToOccasionsScreen() {
    Get.toNamed(AppRouteName.occasions);
  }

  refreshScreen() {
    update();
  }

  // getCurrentPosition() async {
  //   //First check: Check if the user is active the gps in his phone.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     openGpsAlert();
  //     return false;
  //   }
  //   //Second check: Check if the user allow the app to use loaction.
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied ||
  //       permission == LocationPermission.deniedForever) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied ||
  //         permission == LocationPermission.deniedForever) {
  //       allowToUseLocationAlert();
  //       return false;
  //     }
  //   }
  //   //Get the currrent loction of the user.
  //   position = await Geolocator.getCurrentPosition();
  //   valuesController.currentPosition =
  //       LatLng(position.latitude, position.longitude);
  // }

  // openGpsAlert() {
  //   Get.defaultDialog(
  //       title: "الGPS غير مفعل",
  //       middleText: "فعل الgps لتجربة استخدام افضل",
  //       //onWillPop: () => getCurrentPosition(),
  //       textConfirm: 'قمت بالتفعيل',
  //       onConfirm: () {
  //         Get.back();
  //         getCurrentPosition();
  //       },
  //       textCancel: "الغاء",
  //       onCancel: () {});
  // }

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

  // handleGetCurrentPositionResult() async {
  //   GetCurrentPositionResult result = await getCurrentPosition();
  //   if (result.status == 'success') {
  //     valuesController.currentPosition = result.latLng!;
  //   } else {
  //     result.error == 'permission' ? activePermissionAlert() : activeGpsAlert();
  //     print('get current location result = ${result.status}');
  //   }
  // }

  getCurrentLocation() async {
    Position? position = await locationService.getCurrentLocation();
    if (position != null) {
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      valuesController.currentPosition =
          LatLng(position.latitude, position.longitude);
    } else {
      allowToUseLocationAlert();
      print('Failed to get location');
    }
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      currentPage = Get.arguments['page'];
      update();
    }
    getMyProfileData();
    getCurrentLocation();
    super.onInit();
  }
}
