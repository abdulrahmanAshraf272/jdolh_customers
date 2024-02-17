import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class FollowersAndFollowingController extends GetxController {
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController name = TextEditingController();
  List<PersonWithFollowState> data = [];
  StatusRequest statusRequest = StatusRequest.none;
  late String title;

  followUnfollow(int index) {
    followUnfollowRequest(data[index].userId.toString());
    if (data[index].following!) {
      data[index].following = false;
    } else {
      data[index].following = true;
    }
    update();
  }

  followUnfollowRequest(String personId) async {
    var response = await followUnfollowData.postData(
        myServices.sharedPreferences.getString("id")!, personId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('operation followUnfollow done succussfuly');
      } else {
        print('operation followUnfollow done failed');
      }
    }
  }

  onTapCard(int index) {
    //Get.toNamed(AppRouteName.personProfile);
    final person = Person(
        userId: data[index].userId,
        userName: data[index].userName,
        userUsername: data[index].userUsername,
        userImage: data[index].userImage);
    Get.toNamed(AppRouteName.personProfile, arguments: person);
  }

  @override
  void onInit() {
    // title = Get.arguments['title'];
    // String decodedList = Get.arguments['data'];
    // data = jsonDecode(decodedList);
    //data = Get.arguments['data'];

    super.onInit();
  }
}
