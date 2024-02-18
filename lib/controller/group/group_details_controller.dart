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

class GroupDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  GroupsData groupsData = GroupsData(Get.find());
  final GroupsController groupController = Get.put(GroupsController());
  MyServices myServices = Get.find();
  late Group groupSelected;
  late int groupid;
  List<Friend> groupMembers = [];

  getGroupMembers(String groupid) async {
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
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onTapPersonCard(index) {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    if (groupMembers[index].userId != myId) {
      // final person = Person(
      //     userId: groupMembers[index].userId,
      //     userName: groupMembers[index].userName,
      //     userUsername: groupMembers[index].userUsername,
      //     userImage: groupMembers[index].userImage);
      Get.toNamed(AppRouteName.personProfile, arguments: groupMembers[index]);
    }
  }

  onTapLeaveGroup() {
    Get.defaultDialog(
        title: "مغادرة",
        middleText: "هل تريد مغادرة المجموعة؟",
        onConfirm: () {
          leaveGroup();
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  leaveGroup() async {
    groupController.groups.remove(groupSelected);
    var response = await groupsData.leaveGroup(
        myServices.sharedPreferences.getString("id")!,
        groupSelected.groupId.toString());
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
    getGroupMembers(groupSelected.groupId.toString());

    super.onInit();
  }
}
