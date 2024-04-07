// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:jdolh_customers/controller/brand_profile/brand_profile_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/decode_encode_time.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';
import 'package:jdolh_customers/data/models/cart.dart';
import 'package:jdolh_customers/data/models/resOption.dart';
import 'package:jdolh_customers/data/models/reserved_time.dart';
import 'package:jdolh_customers/data/models/worktime_day.dart';

class SetResTimeController extends GetxController with TimeHelper {
  late int bchid;
  late ResOption resOption;
  late int timeout;
  List<ReservedTime> reservedTimes = [];

  StatusRequest statusRequest = StatusRequest.loading;
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
      Get.rawSnackbar(message: 'من فضلك قم باختيار وقت الحجز');
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
      removeReservedTimes(selectedDateFormatted);
      update();
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
      List<TimeOfDay> timeUnits =
          generateTimeUnits(unAvailableTimes[i].resTime!, duration);
      //Remove the reserved units
      availaleWorktime.removeWhere((element) => timeUnits.contains(element));
    }
  }

  getReservedTime() async {
    print('resOption: $resOption');
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.getReservedTime(
        bchid: bchid.toString(), resOption: resOption.resoptionsTitle!);
    statusRequest = handlingData(response);
    print('statusRequest: $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        List data = response['data'];
        reservedTimes = data.map((e) => ReservedTime.fromJson(e)).toList();
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
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

    timeRangeP1 = getAvailableHalfHours(startTimeP1, endTimeP1);

    //Get availabe hours in the period 2 if exist.
    if (worktimeDay.startTimeP2 != null && worktimeDay.endTimeP2 != null) {
      TimeOfDay startTimeP2 = worktimeDay.startTimeP2!;
      TimeOfDay endTimeP2 = worktimeDay.endTimeP2!;
      timeRangeP2 = getAvailableHalfHours(startTimeP2, endTimeP2);
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

  List<TimeOfDay> getAvailableHalfHours(
      TimeOfDay startTime, TimeOfDay endTime) {
    List<TimeOfDay> timeRange = [];

    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    for (int i = startMinutes; i < endMinutes; i += 30) {
      int hour = i ~/ 60;
      int minute = i % 60;
      timeRange.add(TimeOfDay(hour: hour, minute: minute));
    }

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

  // List<TimeOfDay> findCommonTimes(List<List<TimeOfDay>> lists) {
  //   // Create a map to store the occurrence count of each TimeOfDay in each list
  //   Map<TimeOfDay, int> timeCount = {};

  //   // Iterate through each list and count the occurrences of each TimeOfDay
  //   for (List<TimeOfDay> timeList in lists) {
  //     for (TimeOfDay time in timeList) {
  //       timeCount[time] = (timeCount[time] ?? 0) + 1;
  //     }
  //   }

  //   // Filter the TimeOfDay instances that occur in all lists
  //   List<TimeOfDay> commonTimes = timeCount.keys
  //       .where((time) => timeCount[time] == lists.length)
  //       .toList();

  //   return commonTimes;
  // }

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

  /////////////
  List<TimeOfDay> generateTimeUnits(String time, int duration) {
    List<TimeOfDay> timeSlots = [];

    // Parse the input time string
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Generate time slots
    while (duration > 0) {
      timeSlots.add(TimeOfDay(hour: hour, minute: minute));
      minute += duration >= 60 ? 30 : duration;
      if (minute >= 60) {
        hour++;
        minute -= 60;
      }
      duration -= duration >= 60 ? 30 : duration;
    }

    return timeSlots;
  }
  //example:
// List<TimeOfDay> slots1 = generateTimeSlots('10:00', 60);
// print(slots1); // Output: [TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 10, minute: 30)]
}
