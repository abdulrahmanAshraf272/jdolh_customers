import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/create_group_controller.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/controller/occasion/create_occasion_controller.dart';
import 'package:jdolh_customers/controller/occasion/edit_occasion_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class AddToOccasionCreatedController extends GetxController {
  MainController mainController = Get.put(MainController());
  TextEditingController searchController = TextEditingController();
  OccasionsData occasionsData = OccasionsData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  EditOccasionController editOccasionController = Get.find();

  List<PersonWithFollowState> following = [];
  List<PersonWithFollowState> myfollowingFiltered = [];

  addMember(int index) async {
    var response = await occasionsData.addToOccasion(
        editOccasionController.occasionId.toString(),
        myfollowingFiltered[index].userId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        editOccasionController.members.add(myfollowingFiltered[index]);
        print('adding member done successfuly ====');
        Get.back();
      }
    }
  }

  void updateList(String value) {
    //this is the function that will filter our list.

    myfollowingFiltered = following
        .where((element) =>
            element.userName!.contains(value) ||
            element.userUsername!.contains(value))
        .toList();
    update();
  }

  getMyFollowing() {
    following = List.from(mainController.myfollowing);
    print(mainController.myfollowing.length);
    List members = List.from(editOccasionController.members);

    for (int i = 0; i < members.length; i++) {
      for (int j = 0; j < following.length; j++) {
        if (following[j].userId == members[i].userId) {
          print('remove ${following[j].userName}');
          following.remove(following[j]);
        }
      }
    }
    return following;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myfollowingFiltered = List.from(getMyFollowing());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
}
