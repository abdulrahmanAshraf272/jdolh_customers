import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
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
  String occasionDateTime = '';
  String occasionLocation = '';
  String occasionLat = '';
  String occasionLong = '';
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();

  List<PersonWithFollowState> members = [];
  List<int> membersId = [];
  //MainController mainController = Get.find();
  ValuesController valuesController = Get.find();
  OccasionsController occasionsController = Get.find();
  DateTime? dateTime;

  createOccasion() async {
    if (occasionTitle.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف عنوان للمناسبة!');
      return;
    }
    if (occasionDateTime == '') {
      Get.rawSnackbar(message: 'حدد تاريخ المناسبة!');
      return;
    }
    String membersIdString = membersId.join(",");
    statusRequest = StatusRequest.loading;
    update();
    var response = await occasionData.createOccasion(
        myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("name")!,
        occasionTitle.text,
        dateTime.toString(),
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
        valuesController.addOccasion(newOccasion);
        Get.back();
        Get.rawSnackbar(message: 'تم انشاء المجموعة بنجاح!');
      }
    }
    update();
  }

  // addOccasionToLocale(response) {
  //   Occasion newOccasion = Occasion.fromJson(response['data']);
  //   valuesController.acceptedOccasions.add(newOccasion);
  // }

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

  pickDateTime(BuildContext context) async {
    dateTime = await showOmniDateTimePicker(
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
        if (dateTime == DateTime(2024, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    if (dateTime != null) {
      occasionDateTime = formatDateTime(dateTime.toString());
      update();
      print("dateTime: $dateTime");
    }
  }

  String formatDateTime(String inputDateTime) {
    DateTime dateTime = DateTime.parse(inputDateTime);
    String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
    return formattedDateTime;
  }

  String parseFormattedDateTime(String formattedDateTime) {
    DateTime dateTime =
        DateFormat('yyyy-MM-dd h:mm a').parse(formattedDateTime);
    String parsedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss.S').format(dateTime);
    return parsedDateTime;
  }

  @override
  void dispose() {
    super.dispose();
    occasionTitle.dispose();
  }
}
