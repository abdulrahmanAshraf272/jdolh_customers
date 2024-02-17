import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/edit_group_controller.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class AddToGroupCreatedController extends GetxController {
  EditGroupController editGroupController = Get.put(EditGroupController());
  MainController mainController = Get.put(MainController());
  TextEditingController searchController = TextEditingController();
  List<PersonWithFollowState> following = [];
  List<PersonWithFollowState> myfollowingFiltered = [];
  StatusRequest statusRequest = StatusRequest.none;
  GroupsData groupsData = GroupsData(Get.find());

  void updateList(String value) {
    //this is the function that will filter our list.
    myfollowingFiltered = following
        .where((element) =>
            element.userName!.contains(value) ||
            element.userUsername!.contains(value))
        .toList();
    update();
  }

  addMember(int index) async {
    var response = await groupsData.addToGroup(editGroupController.groupid,
        myfollowingFiltered[index].userId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        editGroupController.groupMembers.add(myfollowingFiltered[index]);
        print('adding member done successfuly ====');
        Get.back();
      }
    }
  }

  // deleteFromListPeopleAddedBefore() {
  //   for (int i = 0; i < myfollowing.length; i++) {
  //     if (membersIDs.toString().contains(myfollowing[i].userId.toString())) {
  //       myfollowing.remove(myfollowing[i]);
  //     }
  //   }
  // }
  getMembersID() {
    var membersIDs = [];
    editGroupController.groupMembers.forEach((element) {
      membersIDs.add(element.userId);
    });
    return membersIDs;
  }

  getMyFollowing() {
    following = List.from(mainController.myfollowing);
    print(mainController.myfollowing.length);
    List members = List.from(editGroupController.groupMembers);

    for (int i = 0; i < members.length; i++) {
      for (int j = 0; j < following.length; j++) {
        if (following[j].userId == members[i].userId) {
          print('remove ${following[j].userName}');
          following.remove(following[j]);
        }
      }
    }

    print(editGroupController.groupMembers.length);
    return following;
  }

  @override
  void onInit() {
    super.onInit();

    // myfollowing = mainController.myfollowing;
    // myfollowing.forEach((element) {
    //   print(element.userId);
    // });
    // print('ssss');

    // print(getMembersID());
    myfollowingFiltered = List.from(getMyFollowing());
  }
}
