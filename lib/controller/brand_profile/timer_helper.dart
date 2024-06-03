// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:jdolh_customers/core/functions/decode_encode_time.dart';
import 'package:jdolh_customers/data/models/worktime_day.dart';

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
