// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/functions/decode_encode_time.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/resOption.dart';
import 'package:jdolh_customers/data/models/worktime_day.dart';

class SetResTimeController extends GetxController with TimeHelper {
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

  //late WorktimeDay worktimeDay;
  List<TimeOfDay> availaleWorktime = [];

  onTapSave() {
    if (selectedTime != '') {
      String selectedDateTime = '$selectedDateFormatted $selectedTime';
      Get.back(result: selectedDateTime);
    }
  }

  getCommonAvailableTime() {
    availaleWorktime.clear();

    ResOption selectedResOption = brandProfileController.selectedResOption;
    List<Cart> carts = brandProfileController.carts;
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
      update();
    }
  }

  @override
  void onInit() {
    getCommonAvailableTime();

    super.onInit();
  }
}

mixin TimeHelper {
  List<TimeOfDay> getAvailaleHoursTwoPeriods(String worktime) {
    List<TimeOfDay> timeRangeP1 = [];
    List<TimeOfDay> timeRangeP2 = [];
    WorktimeDay worktimeDay = decodeTimeCustom(worktime);

    TimeOfDay startTimeP1 = worktimeDay.startTimeP1;
    TimeOfDay endTimeP1 = worktimeDay.endTimeP1;

    timeRangeP1 = getAvailaleHours(startTimeP1, endTimeP1);

    //Get availabe hours in the period 2 if exist.
    if (worktimeDay.startTimeP2 != null && worktimeDay.endTimeP2 != null) {
      TimeOfDay startTimeP2 = worktimeDay.startTimeP2!;
      TimeOfDay endTimeP2 = worktimeDay.endTimeP2!;
      timeRangeP2 = getAvailaleHours(startTimeP2, endTimeP2);
    }

    //To delete any repeated time , تشيل اي وقت مكرر
    Set<TimeOfDay> timeRangeP1Set = timeRangeP1.toSet();
    Set<TimeOfDay> timeRangeP2Set = timeRangeP2.toSet();
    Set<TimeOfDay> totalRange = {...timeRangeP1Set, ...timeRangeP2Set};

    List<TimeOfDay> timeRange = totalRange.toList();

    return timeRange;
  }

  List<TimeOfDay> getAvailaleHours(TimeOfDay startTime, TimeOfDay endTime) {
    List<TimeOfDay> timeRange = [];

    // Convert startTime and endTime to minutes
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    // Iterate through the time range and add each hour to the list
    for (int i = startMinutes; i <= endMinutes; i += 60) {
      int hour = i ~/ 60;
      int minute = i % 60;
      timeRange.add(TimeOfDay(hour: hour, minute: minute));
    }

    timeRange.removeLast();

    return timeRange;
  }

  List<TimeOfDay> findCommonAvailableHours(List<String> worktime) {
    List<TimeOfDay> commonTimes = [];
    List<List<TimeOfDay>> lists = [];

    //get availabe time for each worktimeString
    for (int i = 0; i < worktime.length; i++) {
      //Check if any worktimeString is '' , it means its holydoy(no work) return the list empty.
      if (worktime[i] == '') {
        return commonTimes;
      }

      List<TimeOfDay> availaleWorktime =
          getAvailaleHoursTwoPeriods(worktime[i]);
      lists.add(availaleWorktime);
    }

    // Create a map to store the occurrence count of each TimeOfDay in each list
    Map<TimeOfDay, int> timeCount = {};

    // Iterate through each list and count the occurrences of each TimeOfDay
    for (List<TimeOfDay> timeList in lists) {
      for (TimeOfDay time in timeList) {
        timeCount[time] = (timeCount[time] ?? 0) + 1;
      }
    }

    // Filter the TimeOfDay instances that occur in all lists
    commonTimes = timeCount.keys
        .where((time) => timeCount[time] == lists.length)
        .toList();

    return commonTimes;
  }

  List<TimeOfDay> findCommonTimes(List<List<TimeOfDay>> lists) {
    // Create a map to store the occurrence count of each TimeOfDay in each list
    Map<TimeOfDay, int> timeCount = {};

    // Iterate through each list and count the occurrences of each TimeOfDay
    for (List<TimeOfDay> timeList in lists) {
      for (TimeOfDay time in timeList) {
        timeCount[time] = (timeCount[time] ?? 0) + 1;
      }
    }

    // Filter the TimeOfDay instances that occur in all lists
    List<TimeOfDay> commonTimes = timeCount.keys
        .where((time) => timeCount[time] == lists.length)
        .toList();

    return commonTimes;
  }

  String displayTime(TimeOfDay? time, BuildContext context) {
    if (time != null) {
      return time.format(context).toString();
    } else {
      return '';
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }
}
