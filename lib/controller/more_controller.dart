import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';

class MoreController extends GetxController {
  StatusRequest statusFriendsActivity = StatusRequest.none;
  ActivityData activityData = ActivityData(Get.find());
  List<Activity> myActivities = [];
  String image = '';
  String name = '';
  String username = '';
  MyServices myServices = Get.find();
  ValuesController valuesController = Get.put(ValuesController());
  List<Friend> myfollowers = [];
  List<Friend> myfollowing = [];

  logout() {
    Get.defaultDialog(
        title: 'تسجيل خروج',
        middleText: 'هل تريد تسجيل الخروج؟',
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppRouteName.login);
              myServices.sharedPreferences.setString("step", "1");
            },
            child: const Text('نعم'),
          ),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('الغاء'))
        ]);
  }

  gotoFollowers() {
    Get.to(() =>
            FollowersAndFollowingScreen(title: 'متابعين', data: myfollowers))!
        .then((value) => getFollowersFollowingFromValuesController());
  }

  gotoFollowing() {
    Get.to(() =>
            FollowersAndFollowingScreen(title: 'متابعون', data: myfollowing))!
        .then((value) => getFollowersFollowingFromValuesController());
  }

  getUserActivities() async {
    statusFriendsActivity = StatusRequest.loading;
    update();
    var response = await activityData.getUserActivities(
        userid: myServices.getUserid(), myId: myServices.getUserid());
    statusFriendsActivity = handlingData(response);
    if (statusFriendsActivity == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parsingDataFromJsonToDartList(response) {
    List data = response['data'];
    myActivities = data.map((e) => Activity.fromJson(e)).toList();
  }

  gotoFriendsActivities() {
    Get.toNamed(AppRouteName.friendsActivities,
            arguments: {'activities': myActivities, "pageStatus": 2})!
        .then((value) => getUserActivities());
  }

  getFollowersFollowingFromValuesController() {
    myfollowers = List.from(valuesController.myfollowers);
    myfollowing = List.from(valuesController.myfollowing);
    update();
  }

  @override
  void onInit() {
    image = myServices.getImage();
    name = myServices.getName();
    username = myServices.getUsername();
    getUserActivities();
    getFollowersFollowingFromValuesController();
    super.onInit();
  }
}
