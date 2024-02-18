import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/create_group_controller.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/controller/occasion/create_occasion_controller.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class AddToOccasionController extends GetxController {
  ValuesController valuesController = Get.find();
  CreateOccasionController createOccasionController = Get.find();
  TextEditingController searchController = TextEditingController();

  List<Friend> myfollowing = [];

  List<int> _membersId = [];
  List<Friend> _members = [];
  List<Friend> myfollowingFiltered = [];

  addRemoveMember(index) {
    int userId = myfollowingFiltered[index].userId!;
    if (_membersId.contains(userId)) {
      _membersId.remove(userId);
      _members.remove(myfollowingFiltered[index]);
    } else {
      _membersId.add(userId);
      _members.add(myfollowingFiltered[index]);
    }
    update();
  }

  saveChanges() {
    createOccasionController.membersId = _membersId;
    createOccasionController.members = _members;
    Get.back();
  }

  void updateList(String value) {
    //this is the function that will filter our list.

    myfollowingFiltered = myfollowing
        .where((element) =>
            element.userName!.contains(value) ||
            element.userUsername!.contains(value))
        .toList();
    update();
  }

  getTextButton(index) {
    if (_members.contains(myfollowingFiltered[index])) {
      return textRemove;
    } else {
      return textAdd;
    }
  }

  getTextColor(index) {
    if (_members.contains(myfollowingFiltered[index])) {
      return AppColors.redButton;
    } else {
      return AppColors.secondaryColor;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myfollowing = List.from(valuesController.myfollowing);
    myfollowingFiltered = List.from(myfollowing);
    _members = List.from(createOccasionController.members);
    _membersId = List.from(createOccasionController.membersId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
}
