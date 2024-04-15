import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/data/models/friend.dart';

class AddMembersController extends GetxController {
  TextEditingController searchController = TextEditingController();
  ValuesController valuesController = Get.put(ValuesController());
  List<Friend> followingBeforeFiltered = [];
  List<Friend> following = [];
  List<Friend> members = [];

  onTapAdd(int index) {
    Get.back(result: following[index]);
  }

  void updateList(String value) {
    following = followingBeforeFiltered
        .where((element) => element.userUsername!.contains(value))
        .toList();
    update();
  }

  @override
  void onInit() {
    following = List.from(valuesController.myfollowing);
    followingBeforeFiltered = List.from(valuesController.myfollowing);
    if (Get.arguments != null) {
      //Recieve members already added
      members = Get.arguments['members'];
      print(members.length);
      //Remove members already added

      following.removeWhere((followingFriend) =>
          members.any((member) => member.userId == followingFriend.userId));
      followingBeforeFiltered.removeWhere((followingFriend) =>
          members.any((member) => member.userId == followingFriend.userId));
    }

    super.onInit();
  }
}
