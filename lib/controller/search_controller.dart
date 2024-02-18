import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/data_source/remote/search_person.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/screens/person_profile_screen.dart';

class SearchScreenController extends GetxController {
  bool isPersonSearch = true;
  StatusRequest statusRequest = StatusRequest.none;
  SearchPersonData searchPersonData = SearchPersonData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController name = TextEditingController();
  List<Friend> data = [];
  ValuesController valuesController = Get.find();

  activePersonSearch() {
    isPersonSearch = true;
    update();
  }

  inactivePersonSearch() {
    isPersonSearch = false;
    update();
  }

  seachOnTap() {
    if (isPersonSearch) {
      getPeopleSearchedFor();
    }
  }

  getPeopleSearchedFor() async {
    statusRequest = StatusRequest.loading;
    update();
    data.clear();
    var response = await searchPersonData.postData(
        myServices.sharedPreferences.getString("id")!, name.text);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseJsonData = response['data'];
        print('$responseJsonData');
        //parsing jsonList to DartList.
        data = responseJsonData.map((e) => Friend.fromJson(e)).toList();
        remoreMyselfIfWriteMyName();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  followUnfollow(int index) {
    followUnfollowRequest(data[index].userId.toString());
    valuesController.addAndRemoveFollowing(data[index]);
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

  remoreMyselfIfWriteMyName() {
    //Remove me if i write my
    for (int i = 0; i < data.length; i++) {
      if (data[i].userId.toString() ==
          myServices.sharedPreferences.getString("id")!) {
        data.remove(data[i]);
      }
    }
  }

  onTapCard(int index) {
    //Get.toNamed(AppRouteName.personProfile);

    // final person = Person(
    //     userId: data[index].userId,
    //     userName: data[index].userName,
    //     userUsername: data[index].userUsername,
    //     userImage: data[index].userImage);
    Get.toNamed(AppRouteName.personProfile, arguments: data[index]);
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
  }
}
