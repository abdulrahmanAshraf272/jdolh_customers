import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/group.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/view/widgets/custom_time_picker.dart';
import 'package:geocoding/geocoding.dart';

class CreateOccasionController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController occasionTitle = TextEditingController();
  TextEditingController locationLink = TextEditingController();

  String occasionDateTime = '';
  String occasionLocation = '';
  LatLng? latLngSelected;
  String occasionLat = '';
  String occasionLong = '';
  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();

  List<Friend> members = [];
  OccasionsController occasionsController = Get.put(OccasionsController());
  DateTime? dateTime;

  TimeOfDay? timeSelected;

  String? selectedTimeFormatted;
  DateTime selectedDate = DateTime.now();
  String? selectedDateFormatted;

  List<Group> groups = [];

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members, 'withGroups': true});
    if (result != null) {
      if (result is Friend) {
        members.add(result);
        addMember(result);
      } else if (result is Group) {
        if (checkIfGroupIsAdded(result)) {
          return;
        }
        groups.add(result);
        addGroup(result);
      }
      update();
    }
  }

  createOccasion() async {
    if (checkAllFieldsAdded()) {
      CustomDialogs.loading();
      var response = await occasionData.createOccasion(
        myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("name")!,
        occasionTitle.text,
        selectedDateFormatted ?? '',
        selectedTimeFormatted ?? '',
        occasionLocation,
        occasionLat,
        occasionLong,
        locationLink.text,
      );
      CustomDialogs.dissmissLoading();
      statusRequest = handlingData(response);
      update();
      print('status ==== $statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Occasion newOccasion = Occasion.fromJson(response['data']);
          newOccasion.acceptstatus = 1;
          newOccasion.creator = 1;
          occasionsController.myOccasions.add(newOccasion);
          CustomDialogs.success('تم انشاء المناسبة');
          Get.back();
        } else {
          CustomDialogs.failure();
        }
      } else {
        update();
      }
    }
  }

  bool checkAllFieldsAdded() {
    if (occasionTitle.text.isEmpty) {
      Get.rawSnackbar(message: 'اضف عنوان للمناسبة!');
      return false;
    }
    if (selectedDateFormatted == null) {
      Get.rawSnackbar(message: 'حدد تاريخ المناسبة!');
      return false;
    }
    if (selectedTimeFormatted == null) {
      Get.rawSnackbar(message: 'حدد وقت المناسبة!');
      return false;
    }
    return true;
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
    CustomDialogs.loading();
    var response =
        await occasionData.deleteMember('', members[index].userId.toString());
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        members.remove(members[index]);
      } else {
        CustomDialogs.failure();
      }
    }
    update();
  }

  bool checkIfGroupIsAdded(Group group) {
    for (var existingGroup in groups) {
      if (existingGroup.groupId == group.groupId) {
        Get.rawSnackbar(message: 'تم اضافة هذه المجموعة بالفعل');
        return true;
      }
    }
    return false;
  }

  addGroup(Group group) async {
    var response = await occasionData.addGroupToOccasion(
        occasionid: '',
        groupid: group.groupId.toString(),
        groupName: group.groupName ?? '',
        creatorid: myServices.getUserid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('adding ${group.groupName} is done');
      } else {
        print('adding memeber failed');
      }
    }
  }

  deleteGroup(int index) async {
    CustomDialogs.loading();
    var response = await occasionData.deleteGroupFromOccasion(
        occasionid: '',
        groupName: groups[index].groupName ?? '',
        creatorid: myServices.getUserid());
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        groups.remove(groups[index]);
      } else {
        print('adding memeber failed');
      }
    }
    update();
  }

  addMember(Friend member) async {
    var response = await occasionData.addMember(
        occasionid: '',
        userid: member.userId.toString(),
        creatorid: myServices.getUserid());
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

  // pickDateTime(BuildContext context) async {
  //   dateTime = await showOmniDateTimePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
  //     lastDate: DateTime.now().add(
  //       const Duration(days: 3652),
  //     ),
  //     is24HourMode: false,
  //     isShowSeconds: false,
  //     minutesInterval: 1,
  //     secondsInterval: 1,
  //     isForce2Digits: true,
  //     borderRadius: const BorderRadius.all(Radius.circular(16)),
  //     constraints: const BoxConstraints(
  //       maxWidth: 350,
  //       maxHeight: 650,
  //     ),
  //     transitionBuilder: (context, anim1, anim2, child) {
  //       return FadeTransition(
  //         opacity: anim1.drive(
  //           Tween(
  //             begin: 0,
  //             end: 1,
  //           ),
  //         ),
  //         child: child,
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 200),
  //     barrierDismissible: true,
  //     // selectableDayPredicate: (dateTime) {
  //     //   // Disable 25th Feb 2023
  //     //   if (dateTime == DateTime(2024, 2, 26)) {
  //     //     return false;
  //     //   } else {
  //     //     return true;
  //     //   }
  //     // },
  //   );
  //   if (dateTime != null) {
  //     occasionDateTime = formatDateTime(dateTime.toString());
  //     update();
  //     print("dateTime: $dateTime");
  //   }
  // }

  // String formatDateTime(String inputDateTime) {
  //   DateTime dateTime = DateTime.parse(inputDateTime);
  //   String formattedDateTime = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
  //   return formattedDateTime;
  // }

  // String parseFormattedDateTime(String formattedDateTime) {
  //   DateTime dateTime =
  //       DateFormat('yyyy-MM-dd h:mm a').parse(formattedDateTime);
  //   String parsedDateTime =
  //       DateFormat('yyyy-MM-dd HH:mm:ss.S').format(dateTime);
  //   return parsedDateTime;
  // }

  goToAddLocation() async {
    var result = await Get.toNamed(AppRouteName.selectAddressScreen);

    if (result != null) {
      LatLng myLatLng = result as LatLng;
      occasionLat = myLatLng.latitude.toString();
      occasionLong = myLatLng.longitude.toString();
      print('selectedLocation ===> $myLatLng');

      List<Placemark> placemarks =
          await placemarkFromCoordinates(myLatLng.latitude, myLatLng.longitude);
      occasionLocation =
          '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}';
      print('myLocation ====> $occasionLocation');
      update();
    } else {
      print('no location selected');
    }
  }

  clearNullMemebers() async {
    var response = await occasionData.clearMembers(
      myServices.sharedPreferences.getString("id")!,
    );
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('clear memebers is Done');
      } else {
        print('the memebers is already empty');
      }
    }
  }

  void showCustomTimePicker(BuildContext context) {
    final initialTime = TimeOfDay.now();
    TimeOfDay timeHelper = TimeOfDay.now();

    //timeHelper = initialAdjustedTime;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CustomTimePicker(
            initialTime: initialTime,
            onTimeSelected: (selectedTime) {
              timeHelper = selectedTime;
            },
            onTapSave: () {
              Get.back();

              timeSelected = timeHelper;
              selectedTimeFormatted = formatTimeOfDay(timeSelected!);
              update();
            },
            onTapReset: () {
              Get.back();
              timeSelected = null;
              selectedTimeFormatted = null;
              update();
            },
          ),
        );
      },
    );
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) => DateFormat('HH:mm')
      .format(DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute));

  String timeInAmPm() {
    if (selectedTimeFormatted != null) {
      final parts = selectedTimeFormatted!.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final dateTime = DateTime(0, 0, 0, hour, minute);
      final formatter = DateFormat('h:mm a');
      return formatter.format(dateTime);
    } else {
      return 'اختر وقت المناسبة';
    }
  }

  // String formatTimeOfDay(TimeOfDay timeOfDay) {
  //   final now = DateTime.now();
  //   final dateTime = DateTime(
  //       now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  //   final formatter = DateFormat.jm(); // Adjust the pattern as needed
  //   return formatter.format(dateTime);
  // }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print(selectedDate);
      selectedDateFormatted = DateFormat('yyyy-MM-dd').format(selectedDate);
      update();
    }
  }

  @override
  void onInit() {
    clearNullMemebers();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    occasionTitle.dispose();
  }
}
