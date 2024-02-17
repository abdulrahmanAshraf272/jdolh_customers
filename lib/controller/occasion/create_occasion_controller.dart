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
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CreateOccasionController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController occasionTitle = TextEditingController();
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

  createOccasion() async {
    if (occasionTitle.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف عنوان للمناسبة!');
      return;
    }
    String membersIdString = membersId.join(",");
    statusRequest = StatusRequest.loading;
    update();
    var response = await occasionData.createOccasion(
        myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("name")!,
        occasionTitle.text,
        occasionDateTime,
        occasionLocation,
        occasionLat,
        occasionLong,
        membersIdString);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Occasion newOccasion = Occasion.fromJson(response['data']);
        print(newOccasion.occasionTitle);
        occasionsController.acceptedOccasions.add(newOccasion);
        Get.back();
        Get.rawSnackbar(message: 'تم انشاء المجموعة بنجاح!');
      }
    }
    update();
  }

  addOccasionToLocale(response) {}

  removeMember(index) {
    membersId.remove(members[index].userId!);
    members.remove(members[index]);

    update();
  }

  onTapAddMembers() {
    Get.toNamed(AppRouteName.addToOccasion)!.then((value) => refreshScreen());
  }

  refreshScreen() {
    update();
  }

  PickDateTime() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
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
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );

    print("dateTime: $dateTime");
  }

  @override
  void dispose() {
    super.dispose();
    occasionTitle.dispose();
  }
}
