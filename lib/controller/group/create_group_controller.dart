import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/groups_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/group.dart';

class CreateGroupController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController groupName = TextEditingController();
  GroupsData groupsData = GroupsData(Get.find());
  final GroupsController groupController = Get.put(GroupsController());
  MyServices myServices = Get.find();
  // late Group groupSelected;
  // late int groupid;
  List<Friend> members = [];
  List<int> membersId = [];

  createGroup() async {
    if (groupName.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف اسم للمجموعة!');
      return;
    }
    if (membersId.isEmpty) {
      Get.rawSnackbar(message: 'اضف اعضاء للمجموعة!');
      return;
    }
    String membersIdString = membersId.join(",");
    statusRequest = StatusRequest.loading;
    update();
    var response = await groupsData.createGroup(
        myServices.sharedPreferences.getString("id")!,
        groupName.text,
        membersIdString);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        //Adding the new Group created to local data to view.
        Group groupCreated = Group.fromJson(response['data']);
        groupCreated.groupDatecreated =
            groupController.convertDate(groupCreated.groupDatecreated!);
        groupController.groups.add(groupCreated);

        Get.back();
        Get.rawSnackbar(message: 'تم انشاء المجموعة بنجاح!');
      }
    }
    update();
  }

  removeMember(index) {
    membersId.remove(members[index].userId!);
    members.remove(members[index]);

    update();
  }

  onTapAddMembers() {
    Get.toNamed(AppRouteName.addToGroup)!.then((value) => refreshScreen());
  }

  refreshScreen() {
    update();
  }

  @override
  void dispose() {
    super.dispose();
    groupName.dispose();
  }
}
