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
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class EditGroupController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  GroupsData groupsData = GroupsData(Get.find());
  final GroupsController groupController = Get.put(GroupsController());
  MyServices myServices = Get.find();
  late Group groupSelected;
  late String groupid;
  TextEditingController newGroupNameController = TextEditingController();
  List<Friend> members = [];
  void showGroupNameDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('تغيير اسم المجموعة'),
        content: CustomTextField(
            textEditingController: newGroupNameController,
            hintText: 'أضف الاسم الجديد'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              changeGroupName();
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  changeGroupName() async {
    CustomDialogs.loading();
    var response = await groupsData.editGroupName(
        groupId: groupSelected.groupId.toString(),
        newName: newGroupNameController.text);
    statusRequest = handlingData(response);
    CustomDialogs.dissmissLoading();
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم تغيير اسم المجموعة');
        groupSelected.groupName = newGroupNameController.text;
        groupController.groups
            .firstWhere((element) => element == groupSelected)
            .groupName = newGroupNameController.text;
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  getGroupMembers(String groupid) async {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    statusRequest = StatusRequest.loading;
    update();
    members.clear();
    var response = await groupsData.groupMembers(groupid);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseGroupMembers = response['data'];
        print(responseGroupMembers);
        //parsing jsonList to DartList.
        members = responseGroupMembers.map((e) => Friend.fromJson(e)).toList();
        //remove me form list
        members.removeWhere((element) => element.userId == myId);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
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
        groupid: groupid,
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

  refreshScreen() {
    update();
  }

  onTapPersonCard(index) {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    if (members[index].userId != myId) {
      Get.toNamed(AppRouteName.personProfile, arguments: members[index]);
    }
  }

  onTapRemoveMember(int index) {
    Get.defaultDialog(
        title: "أزالة",
        middleText: "هل تريد ازالة ${members[index].userName} المجموعة؟",
        onConfirm: () {
          Get.back();
          removeMember(index);
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  removeMember(index) async {
    if (members.length == 1) {
      Get.rawSnackbar(message: 'لا يمكنك حذف جميع الاعضاء من المجموعة');
    } else {
      CustomDialogs.loading();
      var response = await groupsData.deleteMember(
          groupid: groupid, userid: members[index].userId.toString());
      CustomDialogs.dissmissLoading();
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          CustomDialogs.success(
              'تم حذف ${members[index].userName} من المجموعة');
          members.remove(members[index]);
          update();
        } else {
          CustomDialogs.failure();
        }
      }
    }

    update();
  }

  onTapDeleteGroup() {
    Get.defaultDialog(
        title: "حذف",
        middleText: "هل تريد حذف المجموعة؟",
        onConfirm: () {
          deleteGroup();
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  deleteGroup() async {
    //Delete group local

    CustomDialogs.loading();
    var response =
        await groupsData.deleteGroup(groupSelected.groupId.toString());
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم حذف المجموعة');
        groupController.groups.remove(groupSelected);
        Get.back();
      } else {
        CustomDialogs.failure();
      }
    }
  }

  @override
  void onInit() async {
    groupSelected = Get.arguments as Group;
    groupid = groupSelected.groupId.toString();
    getGroupMembers(groupid);

    super.onInit();
  }
}
