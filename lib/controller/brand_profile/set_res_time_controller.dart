// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/cart_controller.dart';
import 'package:jdolh_customers/controller/brand_profile/timer_helper.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/resOption.dart';
import 'package:jdolh_customers/data/models/reserved_time.dart';

class SetResTimeController extends GetxController with TimeHelper {
  late int bchid;
  late ResOption resOption;
  late int timeout;
  List<ReservedTime> reservedTimes = [];
  CartController cartController = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());

  List<TimeOfDay> availaleWorktime = [];

  BrandProfileController brandProfileController = Get.find();

  DateTime selectedDate = DateTime.now();
  String selectedDateFormatted =
      DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedDay = DateFormat('EEE').format(DateTime.now());

// =====  Select Time From Available Time ====//
  String selectedTime = '';
  setSelectedTime(int index) {
    selectedTime = formatTimeOfDay(availaleWorktime[index]);
    print('selectedTime: $selectedTime');
    update();
  }

  bool checkSelectedTimeView(int index) {
    if (formatTimeOfDay(availaleWorktime[index]) == selectedTime) {
      return true;
    } else {
      return false;
    }
  }

  ///////////////////////

  onTapSave() {
    if (selectedTime != '') {
      Get.back(result: {'date': selectedDateFormatted, 'time': selectedTime});
    } else {
      Get.rawSnackbar(message: 'من فضلك قم باختيار وقت الحجز'.tr);
    }
  }

  getCommonAvailableTime() {
    availaleWorktime.clear();

    ResOption selectedResOption = brandProfileController.selectedResOption;
    List<Cart> carts = cartController.carts;
    List<String> worktimeForAll = [];
    //Add Bch worktime
    worktimeForAll.add(bchWorktimeForSpecificDay(selectedDay));

    //Add resOption worktime
    if (selectedResOption.resoptionsAlwaysAvailable == 0) {
      worktimeForAll.add(resOptionWorktimeForSpecificDay(selectedDay));
    }

    //Add items worktime
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].itemsAlwaysAvailable == 0) {
        worktimeForAll.add(itemWorktimeForSpecificDay(selectedDay, carts[i]));
      }
    }

    availaleWorktime = findCommonAvailableHours(worktimeForAll);
  }

  bchWorktimeForSpecificDay(String day) {
    BchWorktime bch = brandProfileController.bchWorktime;
    switch (day) {
      case 'Sat':
        return bch.bchworktimeSat;
      case 'Sun':
        return bch.bchworktimeSun;
      case 'Mon':
        return bch.bchworktimeMon;
      case 'Tue':
        return bch.bchworktimeTues;
      case 'Wed':
        return bch.bchworktimeWed;
      case 'Thu':
        return bch.bchworktimeThurs;
      case 'Fri':
        return bch.bchworktimeFri;
    }
  }

  resOptionWorktimeForSpecificDay(String day) {
    ResOption resOption = brandProfileController.selectedResOption;
    switch (day) {
      case 'Sat':
        return resOption.resoptionsSatTime;
      case 'Sun':
        return resOption.resoptionsSunTime;
      case 'Mon':
        return resOption.resoptionsMonTime;
      case 'Tue':
        return resOption.resoptionsTuesTime;
      case 'Wed':
        return resOption.resoptionsWedTime;
      case 'Thu':
        return resOption.resoptionsThursTime;
      case 'Fri':
        return resOption.resoptionsFriTime;
    }
  }

  itemWorktimeForSpecificDay(String day, Cart cart) {
    switch (day) {
      case 'Sat':
        return cart.itemsSatTime;
      case 'Sun':
        return cart.itemsSunTime;
      case 'Mon':
        return cart.itemsMonTime;
      case 'Tue':
        return cart.itemsTuesTime;
      case 'Wed':
        return cart.itemsWedTime;
      case 'Thu':
        return cart.itemsThursTime;
      case 'Fri':
        return cart.itemsFriTime;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      // selectableDayPredicate: (DateTime date) {
      //   // Disable 2024-06-04
      //   if (date.year == 2024 && date.month == 6 && date.day == 4) {
      //     return false;
      //   }
      //   return true;
      // },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print(selectedDate);
      selectedDateFormatted = DateFormat('yyyy-MM-dd').format(selectedDate);
      selectedDay = DateFormat('EEE').format(picked);
      //Reset selected Time
      selectedTime = '';
      print('date: $selectedDate , day: $selectedDateFormatted');
      getCommonAvailableTime();
      removeReservedTimes(selectedDateFormatted);
      removePastTimes();
      update();
    }
  }

  getReservedTime() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.getReservedTime(
        bchid: bchid.toString(), resOption: resOption.resoptionsTitle!);
    statusRequest = handlingData(response);
    print('statusRequest: $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        reservedTimes = data.map((e) => ReservedTime.fromJson(e)).toList();
        print(data);
      } else {
        print('failure get Reserved time');
      }
    }
    update();
  }

  int getNextMultipleOf30(int number) {
    if (number < 30) {
      return 30;
    } else {
      //if its 30 or 60 or 90 save the values as it is
      if (number % 30 == 0) {
        return number;
      } else {
        return ((number ~/ 30) + 1) * 30;
      }
    }
  }

  removeReservedTimes(String selectedDate) {
    List<ReservedTime> unAvailableTimes = [];
    //get the reservation in selected data, and the exceed the countLimit
    for (int i = 0; i < reservedTimes.length; i++) {
      if (reservedTimes[i].resDate == selectedDate &&
          reservedTimes[i].count! >= resOption.resoptionsCountLimit!) {
        unAvailableTimes.add(reservedTimes[i]);
      }
    }

    //get the time units and remove it from available times
    for (int i = 0; i < unAvailableTimes.length; i++) {
      int duration = unAvailableTimes[i].resDuration! + timeout;

      // ================= Here where i approximate the durationt to mutiples of 30 ================================//
      duration = getNextMultipleOf30(duration);
      List<TimeOfDay> timeUnits =
          generateTimeUnits(unAvailableTimes[i].resTime!, duration);
      //Remove the reserved units
      availaleWorktime.removeWhere((element) => timeUnits.contains(element));
    }
  }

  removePastTimes() {
    if (checkIfToday(selectedDateFormatted)) {
      TimeOfDay now = TimeOfDay.now();
      availaleWorktime =
          availaleWorktime.where((time) => isAfterOrEqual(time, now)).toList();
    }
  }

  bool isAfterOrEqual(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour > time2.hour) {
      return true;
    } else if (time1.hour == time2.hour) {
      return time1.minute >= time2.minute;
    }
    return false;
  }

  bool checkIfToday(String selectedDateFormatted) {
    String todayFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return selectedDateFormatted == todayFormatted;
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      bchid = Get.arguments['bchid'];
      resOption = Get.arguments['resOption'];
      timeout = Get.arguments["timeout"];
    }
    await getReservedTime();
    getCommonAvailableTime();
    removeReservedTimes(selectedDateFormatted);
    removePastTimes();
    update();
    super.onInit();
  }
}
