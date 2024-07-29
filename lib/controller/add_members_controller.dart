import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/group.dart';

class AddMembersController extends GetxController {
  TextEditingController searchController = TextEditingController();
  ValuesController valuesController = Get.put(ValuesController());
  List<Friend> followingBeforeFiltered = [];
  List<Friend> following = [];
  List<Friend> members = [];
  StatusRequest statusRequestGroups = StatusRequest.none;
  GroupsData groupsData = GroupsData(Get.find());
  MyServices myServices = Get.find();
  List<Group> groups = [];
  bool withGroups = false;

  onTapAdd(int index) {
    Get.back(result: following[index]);
  }

  onTapAddGroup(int index) {
    Get.back(result: groups[index]);
  }

  void updateList(String value) {
    following = followingBeforeFiltered
        .where((element) =>
            element.userUsername!.contains(value) ||
            element.userName!.contains(value))
        .toList();
    update();
  }

  removeMembersAlreadyAdded() {
    following.removeWhere((followingFriend) =>
        members.any((member) => member.userId == followingFriend.userId));
    followingBeforeFiltered.removeWhere((followingFriend) =>
        members.any((member) => member.userId == followingFriend.userId));
  }

  getAllGroups() async {
    statusRequestGroups = StatusRequest.loading;
    update();
    groups.clear();
    var response = await groupsData.groupsView(
        userId: myServices.sharedPreferences.getString("id")!);
    statusRequestGroups = handlingData(response);
    print('status ==== $statusRequestGroups');
    if (statusRequestGroups == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseGroups = response['data'];
        //parsing jsonList to DartList.
        groups = responseGroups.map((e) => Group.fromJson(e)).toList();
        print(responseGroups);
      } else {
        statusRequestGroups = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    following = List.from(valuesController.myfollowing);
    followingBeforeFiltered = List.from(valuesController.myfollowing);
    if (Get.arguments != null) {
      //Recieve members already added
      members = Get.arguments['members'];
      removeMembersAlreadyAdded();
      if (Get.arguments['withGroups'] != null) {
        withGroups = Get.arguments['withGroups'];
        getAllGroups();
      }
    }

    super.onInit();
  }
}
