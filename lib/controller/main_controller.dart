import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/my_profile.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/screens/appt_details_screen.dart';
import 'package:jdolh_customers/view/screens/appt_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/create_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/more_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/occasions_screen.dart';
import 'package:jdolh_customers/view/screens/schedule_screen.dart';

class MainController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyProfileData myProfileData = MyProfileData(Get.find());
  MyServices myServices = Get.find();
  ValuesController valuesController = Get.put(ValuesController());
  List<PersonWithFollowState> myfollowers = [];
  List<PersonWithFollowState> myfollowing = [];
  List<Occasion> myOccasions = [];
  List<Occasion> acceptedOccasions = [];
  List<Occasion> suspendedOccasions = [];
  int currentPage = 0;
  List<Widget> listPage = [
    const HomeScreen(),
    const ScheduleScreen(),
    const OccasionsScreen(),
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
        print('occasions: ${myOccasions.length}');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parsingDataFromJsonToDartList(response) {
    List responseFollowers = response['followers'];
    List responseFollowing = response['following'];
    List responseOccasoins = response['occasions'];
    myfollowers = responseFollowers
        .map((e) => PersonWithFollowState.fromJson(e))
        .toList();
    myfollowing = responseFollowing
        .map((e) => PersonWithFollowState.fromJson(e))
        .toList();

    myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();
    //make acceptedOccasionList and suspended list
    for (var element in myOccasions) {
      if (element.acceptstatus == 1) {
        acceptedOccasions.add(element);
      } else {
        suspendedOccasions.add(element);
      }
    }

    //Save Date in ValuesController
    valuesController.myOccasions = List.from(myOccasions);
    valuesController.acceptedOccasions = List.from(acceptedOccasions);
    valuesController.suspendedOccasions = List.from(suspendedOccasions);
    valuesController.myfollowing = List.from(myfollowing);
    valuesController.myfollowers = List.from(myfollowers);
  }

  startLoadingAndClearLists() {
    statusRequest = StatusRequest.loading;
    update();
    myfollowers.clear();
    myfollowing.clear();
    myOccasions.clear();
  }

  goToFollwersAndFollowingScreen(bool isFollowers) {
    if (isFollowers) {
      Get.to(() =>
          FollowersAndFollowingScreen(title: textFollowers, data: myfollowers));
    } else {
      Get.to(() =>
          FollowersAndFollowingScreen(title: textFollowing, data: myfollowing));
    }
  }

  goToOccasionsScreen() {
    Get.toNamed(AppRouteName.occasions);
  }

  onTapOccasionCard(int index) {
    if (acceptedOccasions[index].creator == 1) {
      Get.toNamed(AppRouteName.editOccasion,
              arguments: acceptedOccasions[index])!
          .then((value) => refreshScreen());
    } else {
      Get.toNamed(AppRouteName.occasionDetails,
              arguments: acceptedOccasions[index])!
          .then((value) => refreshScreen());
    }
  }

  refreshScreen() {
    update();
  }

  @override
  void onInit() {
    getMyProfileData();

    super.onInit();
  }
}
