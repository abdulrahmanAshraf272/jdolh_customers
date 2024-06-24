import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class ScheduleController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();

  List<Reservation> allRes = [];
  List<Reservation> resToDisplay = [];

  String arabicDate = '';
  DateTime selectedDate = DateTime.now();
  String selectedDateFormatted =
      DateFormat('yyyy-MM-dd').format(DateTime.now());
  int diplayCommingRes = 1;

  gotoReservationDetails(int index) async {
    final result;

    if (resToDisplay[index].resWithInvitors == 0) {
      result = await Get.toNamed(AppRouteName.reservationDetails,
          arguments: {"res": resToDisplay[index]});
    } else {
      result = await Get.toNamed(AppRouteName.reservationWithInvitors,
          arguments: {"res": resToDisplay[index]});
    }

    if (result != null) {
      await getAllRes();
      setResToDisplay(diplayCommingRes);
    }
  }

  setDisplayCommingRes(int value) async {
    diplayCommingRes = value;
    update();

    //Get all res from db and display filtered res
    await getAllRes();
    setResToDisplay(diplayCommingRes);
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
      selectedDateFormatted = DateFormat('yyyy-MM-dd').format(selectedDate);

      getArabicDate(selectedDate);
      setResToDisplay();
    }
  }

  getArabicDate(DateTime dateTime) {
    final dayName = DateFormat('EEEE', 'ar');
    final month = DateFormat('MMMM', 'ar');
    final day = DateFormat('dd');
    final year = DateFormat('yyyy');

    final dayNameFormat = dayName.format(dateTime);
    final monthFormat = month.format(dateTime);
    final dayFormat = day.format(dateTime);
    final yearFormat = year.format(dateTime);

    final date = "$dayNameFormat, $dayFormat $monthFormat, $yearFormat";
    arabicDate = date;
  }

  String displayResTime(int index) {
    String timeString = resToDisplay[index].resTime!;
    timeString = timeString.trim();
    DateTime time = DateFormat.Hm().parse(timeString);
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  getAllRes() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.getAllMyRes(userid: myServices.getUserid());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseValues(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parseValues(response) {
    List data = response['data'];
    allRes = data.map((e) => Reservation.fromJson(e)).toList();
  }

  setResToDisplay([int diplayCommingRes = 1]) {
    resToDisplay.clear();
    if (diplayCommingRes == 0) {
      //Get reservation that i invitred to it.

      //get all approved reservations
      // for (int i = 0; i < allRes.length; i++) {
      //   if (allRes[i].resStatus == 1) {
      //     resToDisplay.add(allRes[i]);
      //   }
      // }
    } else {
      //get all reservation match the selected date.
      for (int i = 0; i < allRes.length; i++) {
        if (allRes[i].resDate == selectedDateFormatted &&
            allRes[i].resStatus == 3) {
          resToDisplay.add(allRes[i]);
        }
      }
    }
    update();
  }

  @override
  void onInit() async {
    getArabicDate(selectedDate);
    await getAllRes();
    setResToDisplay();
    super.onInit();
  }
}
