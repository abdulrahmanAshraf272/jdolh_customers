import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/notification/notification_subscribtion.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/data_source/remote/search_person.dart';
import 'package:jdolh_customers/data/models/friend.dart';

class SearchScreenController extends GetxController {
  bool isPersonSearch = true;
  StatusRequest statusRequest = StatusRequest.none;
  SearchPersonData searchPersonData = SearchPersonData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController name = TextEditingController();
  List<Friend> data = [];
  ValuesController valuesController = Get.put(ValuesController());

  // activePersonSearch() {
  //   isPersonSearch = true;
  //   update();
  // }

  // inactivePersonSearch() {
  //   isPersonSearch = false;
  //   update();
  // }

  seachOnTap(String? value) {
    // if (isPersonSearch) {

    // }
    getPeopleSearchedFor(value);
  }

  getPeopleSearchedFor(String? value) async {
    if (value == null || value == '') {
      data.clear();
      update();
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    data.clear();
    var response = await searchPersonData.postData(
        myServices.sharedPreferences.getString("id")!, value);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseJsonData = response['data'];
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
      NotificationSubscribtion.unfollowUserSubcribeToTopic(data[index].userId);
    } else {
      data[index].following = true;
      NotificationSubscribtion.followUserSubcribeToTopic(data[index].userId);
      NotificationSender.sendFollowingPerson(
          data[index].userId,
          int.parse(myServices.getUserid()),
          myServices.getName(),
          myServices.getImage());
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
    Get.toNamed(AppRouteName.personProfile, arguments: data[index])!
        .then((value) => update());
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
  }

  @override
  void onInit() {
    //getPeopleSearchedFor('');
    super.onInit();
  }
}
