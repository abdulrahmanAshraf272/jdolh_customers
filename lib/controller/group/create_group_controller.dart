import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/groups_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/group.dart';

class CreateGroupController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController groupName = TextEditingController();
  GroupsData groupsData = GroupsData(Get.find());
  GroupsController groupsController = Get.put(GroupsController());
  MyServices myServices = Get.find();

  List<Friend> members = [];

  removeMember(index) {
    deleteMember(index);
  }

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result != null) {
      Friend member = result as Friend;
      members.add(member);
      addMember(member);
      update();
    }
  }

  addMember(Friend member) async {
    var response = await groupsData.addGroupMemeber(
        groupid: '',
        creatorid: myServices.getUserid(),
        userid: member.userId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('adding ${member.userName} is done');
      } else {
        print('adding memeber failed');
      }
    }
  }

  deleteMember(int index) async {
    CustomDialogs.loading();
    var response = await groupsData.deleteMember(
        groupid: '', userid: members[index].userId.toString());
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('status delete:${statusRequest}');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        members.remove(members[index]);
        print(members.length);
      } else {
        print('adding memeber failed');
      }
    }
    update();
  }

  createGroup() async {
    if (groupName.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف اسم للمجموعة!');
      return;
    }
    if (members.isEmpty) {
      Get.rawSnackbar(message: 'اضف اعضاء للمجموعة!');
      return;
    }
    CustomDialogs.loading();
    var response = await groupsData.createGroup(
      creatorid: myServices.sharedPreferences.getString("id")!,
      groupName: groupName.text,
    );
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        //Adding the new Group created to local data to view.
        Group groupCreated = Group.fromJson(response['data']);
        groupCreated.groupDatecreated =
            groupsController.convertDate(groupCreated.groupDatecreated!);
        groupCreated.creator = 1;
        groupsController.groups.add(groupCreated);

        CustomDialogs.success('تم انشاء المجموعة');
        Get.back();
      } else {
        CustomDialogs.failure();
      }
    } else {
      update();
    }
  }

  clearNullMemebers() async {
    var response = await groupsData.clearMembers(
      myServices.sharedPreferences.getString("id")!,
    );
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('clear memebers is Done');
      } else {
        print('the memebers is already empty');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    groupName.dispose();
  }

  @override
  void onInit() {
    clearNullMemebers();
    super.onInit();
  }
}
