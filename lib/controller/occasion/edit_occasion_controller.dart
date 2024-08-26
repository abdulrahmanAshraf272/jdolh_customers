import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/occasion/occasions_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/occasion_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/view/widgets/custom_time_picker.dart';

class EditOccasionController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  OccasionsController occasionsController = Get.put(OccasionsController());
  TextEditingController occasionTitle = TextEditingController();
  TextEditingController locationLink = TextEditingController();
  late Occasion occasionSelected;
  late int occasionId;
  String occasionDateTime = '';
  String occasionLocation = '';
  String occasionLat = '';
  String occasionLong = '';

  OccasionsData occasionData = OccasionsData(Get.find());
  MyServices myServices = Get.find();

  bool isEditHappend = false;

  List<Friend> members = [];
  //List<int> membersId = [];
  //MainController mainController = Get.find();
  //ValuesController valuesController = Get.find();
  //OccasionsController occasionsController = Get.find();
  DateTime? myDateTime;
  TimeOfDay? timeSelected;
  String? selectedTimeFormatted;
  DateTime selectedDate = DateTime.now();
  String? selectedDateFormatted = '';

  editOccasion() async {
    CustomDialogs.loading();
    occasionDateTime = myDateTime.toString();
    var response = await occasionData.editOccasion(
        occasionId.toString(),
        occasionTitle.text,
        selectedDateFormatted ?? '',
        selectedTimeFormatted ?? '',
        occasionLocation,
        occasionLat,
        occasionLong,
        locationLink.text);
    statusRequest = handlingData(response);
    await Future.delayed(const Duration(seconds: lateDuration));
    CustomDialogs.dissmissLoading();
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم تعديل المناسبة');
        OccasionNotification.editOccasion(
            members,
            myServices.getName(),
            myServices.getImage(),
            occasionTitle.text,
            occasionSelected.occasionId!,
            "$selectedDateFormatted $selectedTimeFormatted");
        Get.back(result: true);
      } else {
        Get.back();
      }
    } else {
      CustomDialogs.failure();
      update();
    }
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
        print(members.length);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

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

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result != null) {
      Friend member = result as Friend;
      member.creator = 0;
      member.invitorStatus = 0;
      members.add(member);
      addMember(member);
      update();
    }
  }

  addMember(Friend member) async {
    var response = await occasionData.addMember(
        occasionid: occasionSelected.occasionId.toString(),
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

  String displayMemberStatus(int index) {
    if (members[index].creator == 1) {
      return 'منشئ'.tr;
    } else if (members[index].invitorStatus == 2) {
      return 'اعتذر'.tr;
    } else if (members[index].invitorStatus == 1) {
      return 'مؤكد'.tr;
    } else {
      return 'لم يتم التأكيد'.tr;
    }
  }

  Color displayMemberStatusColor(int index) {
    if (members[index].creator == 1) {
      return AppColors.secondaryColor;
    } else if (members[index].invitorStatus == 0) {
      return Colors.grey;
    } else if (members[index].invitorStatus == 1) {
      return Colors.green;
    } else {
      return AppColors.redText;
    }
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
    var response = await occasionData.deleteMember(
        occasionSelected.occasionId.toString(),
        members[index].userId.toString());
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        members.remove(members[index]);
        print('removing member done successfuly ====');
      } else {
        CustomDialogs.failure();
      }
    }
    update();
  }

  onTapDeleteOccasion() {
    Get.defaultDialog(
        title: "حذف",
        middleText: "هل تريد حذف المناسبة؟",
        onConfirm: () {
          Get.back();
          deleteOccasion();
        },
        textConfirm: 'تأكيد',
        textCancel: 'الغاء',
        onCancel: () {});
  }

  deleteOccasion() async {
    CustomDialogs.loading();
    var response = await occasionData.deleteOccasion(occasionId.toString());
    CustomDialogs.dissmissLoading();
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم حذف المناسبة');
        occasionsController.myOccasions.remove(occasionSelected);
        Get.back(result: true);
        //Delete group local
      } else {
        print('leave group failed');
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

  @override
  void dispose() {
    super.dispose();
    occasionTitle.dispose();
  }

  getDataOfSelectedOccasion() {
    occasionSelected = Get.arguments;
    occasionId = occasionSelected.occasionId!;
    occasionTitle.text = occasionSelected.occasionTitle!;
    //myDateTime = DateTime.parse(occasionSelected.occasionDatetime!);
    //occasionDateTime = formatDateTime(myDateTime.toString());
    //occasionDateTimeOld = formatDateTime(myDateTime.toString());
    selectedDateFormatted = occasionSelected.occasionDate ?? '';
    selectedTimeFormatted = occasionSelected.occasionTime ?? '';
    occasionLocation = occasionSelected.occasionLocation ?? '';
    occasionLat = occasionSelected.occasionLat!;
    occasionLong = occasionSelected.occasionLong!;
    locationLink.text = occasionSelected.locationLink ?? '';
  }

  @override
  void onInit() {
    getDataOfSelectedOccasion();
    getOccasionMembers(occasionSelected.occasionId.toString());
    super.onInit();
  }
}
