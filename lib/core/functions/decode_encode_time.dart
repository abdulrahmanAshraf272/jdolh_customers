import 'package:flutter/material.dart';
import 'package:jdolh_customers/data/models/worktime_day.dart';

encodeTime(TimeOfDay? startTimeP1, TimeOfDay? endTimeP1, TimeOfDay? startTimeP2,
    TimeOfDay? endTimeP2) {
  if (startTimeP1 == null || endTimeP1 == null) {
    return null; // Return null if startTimeP1 or endTimeP1 is null
  }

  String encodedString =
      '${startTimeP1.hour}:${startTimeP1.minute}-${endTimeP1.hour}:${endTimeP1.minute}';

  if (startTimeP2 != null && endTimeP2 != null) {
    encodedString +=
        '|${startTimeP2.hour}:${startTimeP2.minute}-${endTimeP2.hour}:${endTimeP2.minute}';
  }

  return encodedString;
}

WorktimeDay decodeTimeCustom(String encodedString) {
  List<String> periods = encodedString.split('|');
  List<String> period1 = periods[0].split('-');

  TimeOfDay startTimeP1 = parseTimeString(period1[0]);
  TimeOfDay endTimeP1 = parseTimeString(period1[1]);

  WorktimeDay worktimeDay;

  if (periods.length == 2) {
    List<String> period2 = periods[1].split('-');
    TimeOfDay startTimeP2 = parseTimeString(period2[0]);
    TimeOfDay endTimeP2 = parseTimeString(period2[1]);

    worktimeDay = WorktimeDay(
        startTimeP1: startTimeP1,
        endTimeP1: endTimeP1,
        startTimeP2: startTimeP2,
        endTimeP2: endTimeP2);
  } else {
    worktimeDay = WorktimeDay(
        startTimeP1: startTimeP1,
        endTimeP1: endTimeP1,
        startTimeP2: null,
        endTimeP2: null);
  }
  return worktimeDay;
}

Map<String, TimeOfDay?> decodeTimeCustomMoreClean(String encodedString) {
  List<String> periods = encodedString.split('|');
  List<String> period1 = periods[0].split('-');

  TimeOfDay startTimeP1 = parseTimeString(period1[0]);
  TimeOfDay endTimeP1 = parseTimeString(period1[1]);

  if (periods.length == 2) {
    List<String> period2 = periods[1].split('-');
    TimeOfDay startTimeP2 = parseTimeString(period2[0]);
    TimeOfDay endTimeP2 = parseTimeString(period2[1]);

    return {
      'startTimeP1': startTimeP1,
      'endTimeP1': endTimeP1,
      'startTimeP2': startTimeP2,
      'endTimeP2': endTimeP2,
    };
  } else {
    return {
      'startTimeP1': startTimeP1,
      'endTimeP1': endTimeP1,
      'startTimeP2': null,
      'endTimeP2': null,
    };
  }
}

TimeOfDay parseTimeString(String timeString) {
  List<String> timeComponents = timeString.split(':');
  return TimeOfDay(
    hour: int.parse(timeComponents[0]),
    minute: int.parse(timeComponents[1]),
  );
}
