import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/activity_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/checkin.dart';
import 'package:jdolh_customers/data/data_source/remote/groups.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/group.dart';
import 'package:jdolh_customers/data/models/place.dart';

class CheckinConfirmController extends GetxController {
  GroupsData groupsData = GroupsData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  CheckinData checkinData = CheckinData(Get.find());
  TextEditingController comment = TextEditingController();
  MyServices myServices = Get.find();
  late Place placeSelected;
  List<Friend> members = [];
  ValuesController valuesController = Get.put(ValuesController());

  onTapAddMembers() async {
    //Get.toNamed(AppRouteName.addMembersCheckin)!.then((value) => update());
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members, "withGroups": true});
    if (result is Friend) {
      members.add(result);
      update();
    } else if (result is Group) {
      addGroupCheckin(result);
    }
  }

  addGroupCheckin(Group group) async {
    CustomDialogs.loading();
    var response = await groupsData.groupMembers(group.groupId.toString());
    CustomDialogs.dissmissLoading();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List groupMembersJson = response['data'];
        List<Friend> groupMembers =
            groupMembersJson.map((friend) => Friend.fromJson(friend)).toList();
        int myId = int.parse(myServices.getUserid());

        //Remove myself if i am exist in the group
        groupMembers.removeWhere((friend) => friend.userId == myId);

        //Remove any user that already exist in members
        groupMembers.removeWhere((groupUser) =>
            members.any((member) => member.userId == groupUser.userId));
        members.addAll(groupMembers);
        CustomDialogs.success('تم اضافة اعضاء المجموعة');
        update();
      } else {
        CustomDialogs.failure();
        print('adding memeber failed');
      }
    } else {
      print('statusReques: $statusRequest');
      update();
    }
  }

  removeMember(index) {
    members.remove(members[index]);

    update();
  }

  checkin(BuildContext context) async {
    List<int> membersIds = [];
    for (int i = 0; i < members.length; i++) {
      membersIds.add(members[i].userId!);
    }
    String membersIdString = membersIds.join(",");
    CustomDialogs.loading();
    var response = await checkinData.checkin(
        myServices.sharedPreferences.getString("id")!,
        placeSelected.fromGoogle ?? '0',
        placeSelected.placeId.toString(),
        placeSelected.name ?? '',
        placeSelected.type ?? '',
        placeSelected.location ?? '',
        placeSelected.lat.toString(),
        placeSelected.lng.toString(),
        comment.text,
        membersIdString);
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم تسجيل الوصول');
        Get.offAllNamed(AppRouteName.mainScreen);

        ActivityNotification activityNotification = ActivityNotification();
        activityNotification
            .sendCheckinActivityToFollowers(placeSelected.name ?? '');
        // AwesomeDialog(
        //   context: context,
        //   dialogType: DialogType.success,
        //   animType: AnimType.rightSlide,
        //   title: 'تم تسجيل الوصول',
        //   btnOkText: 'حسنا',
        //   onDismissCallback: (dismissType) {
        //     Get.offAllNamed(AppRouteName.mainScreen);
        //   },
        // ).show();
      }
    } else {
      update();
    }
  }

  @override
  void onInit() {
    placeSelected = Get.arguments;
    super.onInit();
  }
}
