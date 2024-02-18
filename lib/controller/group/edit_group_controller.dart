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
import 'package:jdolh_customers/data/models/group_member.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class EditGroupController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  GroupsData groupsData = GroupsData(Get.find());
  final GroupsController groupController = Get.put(GroupsController());
  MyServices myServices = Get.find();
  late Group groupSelected;
  late String groupid;
  TextEditingController newGroupNameController = TextEditingController();
  List<Friend> groupMembers = [];
  void showGroupNameDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('تغيير اسم المجموعة'),
        content: CustomTextField(
            textEditingController: newGroupNameController,
            hintText: 'أضف الاسم الجديد'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('الغاء'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              changeGroupName();
            },
            child: Text('حفظ'),
          ),
        ],
      ),
    );
  }

  changeGroupName() async {
    var response = await groupsData.editGroupName(
        groupSelected.groupId.toString(), newGroupNameController.text);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('change group name done successfuly');
        groupSelected.groupName = newGroupNameController.text;
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
    groupMembers.clear();
    var response = await groupsData.groupMembers(groupid);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseGroupMembers = response['data'];
        print(responseGroupMembers);
        //parsing jsonList to DartList.
        groupMembers =
            responseGroupMembers.map((e) => Friend.fromJson(e)).toList();
        //remove me form list
        groupMembers.removeWhere((element) => element.userId == myId);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onTapAddMember() {
    Get.toNamed(AppRouteName.addToGroupCreated)!
        .then((value) => refreshScreen());
  }

  refreshScreen() {
    update();
  }

  onTapPersonCard(index) {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    if (groupMembers[index].userId != myId) {
      final person = Person(
          userId: groupMembers[index].userId,
          userName: groupMembers[index].userName,
          userUsername: groupMembers[index].userUsername,
          userImage: groupMembers[index].userImage);
      Get.toNamed(AppRouteName.personProfile, arguments: person);
    }
  }

  onTapRemoveMember(int index) {
    Get.defaultDialog(
        title: "أزالة",
        middleText: "هل تريد ازالة ${groupMembers[index].userName} المجموعة؟",
        onConfirm: () {
          Get.back();
          removeMember(index);
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  removeMember(index) async {
    if (groupMembers.length == 1) {
      Get.rawSnackbar(message: 'لا يمكنك حذف جميع الاعضاء من المجموعة');
    } else {
      var response = await groupsData.deleteMember(
          groupid, groupMembers[index].userId.toString());
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          groupMembers.remove(groupMembers[index]);
          print('removing member done successfuly ====');
          update();
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
    groupController.groups.remove(groupSelected);
    //Delete group server
    var response =
        await groupsData.deleteGroup(groupSelected.groupId.toString());
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.back();
      } else {
        print('leave group failed');
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
