import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/formatDateTime.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class EditOccasionController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController occasionTitleOld = TextEditingController();
  TextEditingController occasionTitle = TextEditingController();
  late Occasion occasionSelected;
  late int occasionId;
  String occasionDateTime = '';
  String occasionDateTimeOld = '';
  String occasionLocation = '';
  String occasionLat = '';
  String occasionLong = '';

  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();

  bool isEditHappend = false;

  List<Friend> members = [];
  //List<int> membersId = [];
  //MainController mainController = Get.find();
  ValuesController valuesController = Get.find();
  //OccasionsController occasionsController = Get.find();
  DateTime? myDateTime;

  editOccasion() async {
    if (occasionTitle.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف عنوان للمناسبة!');
      return;
    }
    //check if no value change
    if (occasionTitle.text == occasionTitleOld.text &&
        occasionDateTime == occasionDateTimeOld) {
      print('nothing changed');
      Get.back();
      return;
    }
    statusRequest = StatusRequest.loading;
    occasionDateTime = myDateTime.toString();
    update();
    var response = await occasionData.editOccasion(
      occasionId.toString(),
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
        valuesController.editOccasion(occasionId, occasionTitle.text,
            occasionDateTime, occasionLocation, occasionLat, occasionLong);
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
        members =
            responseOccasionMembers.map((e) => Friend.fromJson(e)).toList();
        //remove me form list
        members.removeWhere((element) => element.userId == myId);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

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
        middleText: "هل تريد ازالة ${members[index].userName} من المناسبة؟",
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

  pickDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      type: OmniDateTimePickerType.dateAndTime,
      context: context,
      initialDate: myDateTime,
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2024, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    if (dateTime != null) {
      myDateTime = dateTime;
      occasionDateTime = formatDateTime(myDateTime.toString());
      update();
      print("dateTime: $myDateTime");
    }
  }

  deleteOccasion() async {
    //Delete group server
    var response = await occasionData.deleteOccasion(occasionId.toString());
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        //Delete group local
        valuesController.removeOccasion(occasionSelected);
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
    occasionTitleOld.text = occasionSelected.occasionTitle!;
    myDateTime = DateTime.parse(occasionSelected.occasionDatetime!);
    occasionDateTime = formatDateTime(myDateTime.toString());
    occasionDateTimeOld = formatDateTime(myDateTime.toString());
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
