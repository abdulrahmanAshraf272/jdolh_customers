import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/activity_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/checkin.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/place.dart';

class CheckinConfirmController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  CheckinData checkinData = CheckinData(Get.find());
  TextEditingController comment = TextEditingController();
  MyServices myServices = Get.find();
  late Place placeSelected;
  List<Friend> members = [];
  List<int> membersId = [];
  ValuesController valuesController = Get.put(ValuesController());

  onTapAddMembers() async {
    //Get.toNamed(AppRouteName.addMembersCheckin)!.then((value) => update());
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result is Friend) {
      members.add(result);
      membersId.add(result.userId!);
      update();
    }
  }

  removeMember(index) {
    membersId.remove(members[index].userId!);
    members.remove(members[index]);

    update();
  }

  checkin(BuildContext context) async {
    String membersIdString = membersId.join(",");
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
        // activityNotification
        //     .sendCheckinActivityToFollowers(placeSelected.name ?? '');
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
