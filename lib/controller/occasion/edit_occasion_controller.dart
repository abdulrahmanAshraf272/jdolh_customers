import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';

class EditOccasionController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController occasionTitle = TextEditingController();
  late Occasion occasionSelected;
  late int occasionId;
  String occasionDateTime = '2022-10-12 10:12:00';
  String occasionLocation = '';
  String occasionLat = '';
  String occasionLong = '';
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();

  List<PersonWithFollowState> members = [];
  List<int> membersId = [];
  MainController mainController = Get.find();
  OccasionsController occasionsController = Get.find();

  editOccasion() async {
    if (occasionTitle.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف عنوان للمناسبة!');
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response = await occasionData.editOccasion(
      myServices.sharedPreferences.getString("id")!,
      occasionTitle.text,
      occasionDateTime,
      occasionLocation,
      occasionLat,
      occasionLong,
    );
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.back();
        Get.rawSnackbar(message: 'تم التعديل بنجاح!');
      }
    }
    update();
  }

  getOccasionMembers(String occasionId) async {
    int myId = int.parse(myServices.sharedPreferences.getString("id")!);
    statusRequest = StatusRequest.loading;
    update();
    members.clear();
    var response = await occasionData.viewInvitors(occasionId);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseOccasionMembers = response['data'];
        print(responseOccasionMembers);
        //parsing jsonList to DartList.
        members = responseOccasionMembers
            .map((e) => PersonWithFollowState.fromJson(e))
            .toList();
        //remove me form list
        members.removeWhere((element) => element.userId == myId);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  // removeMember(index) {
  //   membersId.remove(members[index].userId!);
  //   members.remove(members[index]);

  //   update();
  // }

  onTapAddMembers() {
    Get.toNamed(AppRouteName.addToOccasionCreated)!
        .then((value) => refreshScreen());
  }

  refreshScreen() {
    update();
  }

  onTapRemoveMember(int index) {
    Get.defaultDialog(
        title: "أزالة",
        middleText: "هل تريد ازالة ${members[index].userName} المناسبة؟",
        onConfirm: () {
          Get.back();
          removeMember(index);
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  removeMember(index) async {
    var response = await occasionData.deleteInvitors(
        occasionSelected.occasionId.toString(),
        members[index].userId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        members.remove(members[index]);
        print('removing member done successfuly ====');
      }
    }
    update();
  }

  onTapDeleteOccasion() {
    Get.defaultDialog(
        title: "حذف",
        middleText: "هل تريد حذف المناسبة؟",
        onConfirm: () {
          deleteOccasion();
          Get.back();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  deleteOccasion() async {
    //Delete group server
    var response = await occasionData.deleteOccasion(occasionId.toString());
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        //Delete group local
        mainController.myOccasions.remove(occasionSelected);
        Get.back();
      } else {
        print('leave group failed');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    occasionTitle.dispose();
  }

  getDataOfSelectedOccasion() {
    occasionSelected = Get.arguments;
    occasionId = occasionSelected.occasionId!;
    occasionTitle.text = occasionSelected.occasionTitle!;
    occasionDateTime = occasionSelected.occasionDatetime!;
    occasionLocation = occasionSelected.occasionLocation!;
    occasionLat = occasionSelected.occasionLat!;
    occasionLong = occasionSelected.occasionLong!;
  }

  @override
  void onInit() {
    getDataOfSelectedOccasion();
    getOccasionMembers(occasionSelected.occasionId.toString());
    super.onInit();
  }
}
