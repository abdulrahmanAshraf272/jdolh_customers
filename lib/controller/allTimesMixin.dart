import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/functions/decode_encode_time.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';

mixin AllTimes {
  bool isSatOff = false;
  bool isSunOff = false;
  bool isMonOff = false;
  bool isTuesOff = false;
  bool isWedOff = false;
  bool isThursOff = false;
  bool isFriOff = false;

  switchDayOffSetValue(int i) {
    if (i == 1) {
      isSatOff = !isSatOff;
      satFromP1 = null;
      satFromP2 = null;
      satToP1 = null;
      satToP2 = null;
    } else if (i == 2) {
      isSunOff = !isSunOff;
      sunFromP1 = null;
      sunFromP2 = null;
      sunToP1 = null;
      sunToP2 = null;
    } else if (i == 3) {
      isMonOff = !isMonOff;
      monFromP1 = null;
      monFromP2 = null;
      monToP1 = null;
      monToP2 = null;
    } else if (i == 4) {
      isTuesOff = !isTuesOff;
      tuesFromP1 = null;
      tuesFromP2 = null;
      tuesToP1 = null;
      tuesToP2 = null;
    } else if (i == 5) {
      isWedOff = !isWedOff;
      wedFromP1 = null;
      wedFromP2 = null;
      wedToP1 = null;
      wedToP2 = null;
    } else if (i == 6) {
      isThursOff = !isThursOff;
      thursFromP1 = null;
      thursFromP2 = null;
      thursToP1 = null;
      thursToP2 = null;
    } else if (i == 7) {
      isFriOff = !isFriOff;
      friFromP1 = null;
      friFromP2 = null;
      friToP1 = null;
      friToP2 = null;
    }
  }

  String? satTime;
  String? sunTime;
  String? monTime;
  String? tuesTime;
  String? wedTime;
  String? thursTime;
  String? friTime;

  TimeOfDay? satFromP1;
  TimeOfDay? satToP1;
  TimeOfDay? satFromP2;
  TimeOfDay? satToP2;

  TimeOfDay? sunFromP1;
  TimeOfDay? sunToP1;
  TimeOfDay? sunFromP2;
  TimeOfDay? sunToP2;

  TimeOfDay? monFromP1;
  TimeOfDay? monToP1;
  TimeOfDay? monFromP2;
  TimeOfDay? monToP2;

  TimeOfDay? tuesFromP1;
  TimeOfDay? tuesToP1;
  TimeOfDay? tuesFromP2;
  TimeOfDay? tuesToP2;

  TimeOfDay? wedFromP1;
  TimeOfDay? wedToP1;
  TimeOfDay? wedFromP2;
  TimeOfDay? wedToP2;

  TimeOfDay? thursFromP1;
  TimeOfDay? thursToP1;
  TimeOfDay? thursFromP2;
  TimeOfDay? thursToP2;

  TimeOfDay? friFromP1;
  TimeOfDay? friToP1;
  TimeOfDay? friFromP2;
  TimeOfDay? friToP2;

  allDaysLikeSatDay() {
    sunFromP1 = satFromP1;
    sunToP1 = satToP1;
    sunFromP2 = satFromP2;
    sunToP2 = satToP2;

    monFromP1 = satFromP1;
    monToP1 = satToP1;
    monFromP2 = satFromP2;
    monToP2 = satToP2;

    tuesFromP1 = satFromP1;
    tuesToP1 = satToP1;
    tuesFromP2 = satFromP2;
    tuesToP2 = satToP2;

    wedFromP1 = satFromP1;
    wedToP1 = satToP1;
    wedFromP2 = satFromP2;
    wedToP2 = satToP2;

    thursFromP1 = satFromP1;
    thursToP1 = satToP1;
    thursFromP2 = satFromP2;
    thursToP2 = satToP2;

    friFromP1 = satFromP1;
    friToP1 = satToP1;
    friFromP2 = satFromP2;
    friToP2 = satToP2;
  }

  String displayTime(TimeOfDay? time, BuildContext context) {
    if (time != null) {
      return time.format(context).toString();
    } else {
      return '';
    }
  }

  encodeAllDays() {
    satTime = encodeTime(satFromP1, satToP1, satFromP2, satToP2);
    sunTime = encodeTime(sunFromP1, sunToP1, sunFromP2, sunToP2);
    monTime = encodeTime(monFromP1, monToP1, monFromP2, monToP2);

    tuesTime = encodeTime(tuesFromP1, tuesToP1, tuesFromP2, tuesToP2);
    wedTime = encodeTime(wedFromP1, wedToP1, wedFromP2, wedToP2);
    thursTime = encodeTime(thursFromP1, thursToP1, thursFromP2, thursToP2);
    friTime = encodeTime(friFromP1, friToP1, friFromP2, friToP2);

    // if (!checkIfTimingMakeSense()) {
    //   return false;
    // }

    if (checkAllDaysSetted() == null) {
      return false;
    }
    return true;
  }

  checkAllDaysSetted() {
    //it well be null, if the first periud is null- second periud is optinanl
    if (satTime == null && !isSatOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم السبت');
    } else if (sunTime == null && !isSunOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الأحد');
    } else if (monTime == null && !isMonOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الأثنين');
    } else if (tuesTime == null && !isTuesOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الثلثاء');
    } else if (wedTime == null && !isWedOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الأربعاء');
    } else if (thursTime == null && !isThursOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الخميس');
    } else if (friTime == null && !isFriOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الجمعة');
    } else {
      return true;
    }
  }

  checkIfTimingMakeSense() {
    if (!validateShiftTimings(satFromP1, satToP1, satFromP2, satToP2)) {
      Get.rawSnackbar(message: 'تأكد من ادخال اوقات يوم السبت بشكل صحيح');
      return false;
    }
    if (!validateShiftTimings(sunFromP1, sunToP1, sunFromP2, sunToP2)) {
      Get.rawSnackbar(message: 'تأكد من ادخال اوقات يوم الاحد بشكل صحيح');
      return false;
    }

    return true;
  }

  setTime(TimeOfDay? value, int d) {
    switch (d) {
      case 1:
        satFromP1 = value;
        break;
      case 2:
        satToP1 = value;
        break;
      case 3:
        satFromP2 = value;
        break;
      case 4:
        satToP2 = value;
        break;
      case 5:
        sunFromP1 = value;
        break;
      case 6:
        sunToP1 = value;
        break;
      case 7:
        sunFromP2 = value;
        break;
      case 8:
        sunToP2 = value;
        break;

      case 9:
        monFromP1 = value;
        break;
      case 10:
        monToP1 = value;
        break;
      case 11:
        monFromP2 = value;
        break;
      case 12:
        monToP2 = value;
        break;

      case 13:
        tuesFromP1 = value;
        break;
      case 14:
        tuesToP1 = value;
        break;
      case 15:
        tuesFromP2 = value;
        break;
      case 16:
        tuesToP2 = value;
        break;

      case 17:
        wedFromP1 = value;
        break;
      case 18:
        wedToP1 = value;
        break;
      case 19:
        wedFromP2 = value;
        break;
      case 20:
        wedToP2 = value;
        break;

      case 21:
        thursFromP1 = value;
        break;
      case 22:
        thursToP1 = value;
        break;
      case 23:
        thursFromP2 = value;
        break;
      case 24:
        thursToP2 = value;
        break;

      case 25:
        friFromP1 = value;
        break;
      case 26:
        friToP1 = value;
        break;
      case 27:
        friFromP2 = value;
        break;
      case 28:
        friToP2 = value;
        break;
    }
  }

  ///  ================= To Display Time stored before =================//

  decodeFromStringToTimeOfDay(BchWorktime worktime) {
    //Saturday
    if (worktime.bchworktimeSat != '') {
      Map<String, TimeOfDay?> sat =
          decodeTimeCustomMoreClean(worktime.bchworktimeSat!);
      satFromP1 = sat['startTimeP1'];
      satToP1 = sat['endTimeP1'];
      satFromP2 = sat['startTimeP2'];
      satToP2 = sat['endTimeP2'];
    } else {
      isSatOff = true;
    }

    //Sunday
    if (worktime.bchworktimeSun != '') {
      Map<String, TimeOfDay?> sun =
          decodeTimeCustomMoreClean(worktime.bchworktimeSun!);
      sunFromP1 = sun['startTimeP1'];
      sunToP1 = sun['endTimeP1'];
      sunFromP2 = sun['startTimeP2'];
      sunToP2 = sun['endTimeP2'];
    } else {
      isSunOff = true;
    }

    // Monday
    if (worktime.bchworktimeMon != '') {
      Map<String, TimeOfDay?> mon =
          decodeTimeCustomMoreClean(worktime.bchworktimeMon!);
      monFromP1 = mon['startTimeP1'];
      monToP1 = mon['endTimeP1'];
      monFromP2 = mon['startTimeP2'];
      monToP2 = mon['endTimeP2'];
    } else {
      isMonOff = true;
    }

    // Tuesday
    if (worktime.bchworktimeTues != '') {
      Map<String, TimeOfDay?> tue =
          decodeTimeCustomMoreClean(worktime.bchworktimeTues!);
      tuesFromP1 = tue['startTimeP1'];
      tuesToP1 = tue['endTimeP1'];
      tuesFromP2 = tue['startTimeP2'];
      tuesToP2 = tue['endTimeP2'];
    } else {
      isTuesOff = true;
    }

    // Wednesday
    if (worktime.bchworktimeWed != '') {
      Map<String, TimeOfDay?> wed =
          decodeTimeCustomMoreClean(worktime.bchworktimeWed!);
      wedFromP1 = wed['startTimeP1'];
      wedToP1 = wed['endTimeP1'];
      wedFromP2 = wed['startTimeP2'];
      wedToP2 = wed['endTimeP2'];
    } else {
      isWedOff = true;
    }

    // Thursday
    if (worktime.bchworktimeThurs != '') {
      Map<String, TimeOfDay?> thu =
          decodeTimeCustomMoreClean(worktime.bchworktimeThurs!);
      thursFromP1 = thu['startTimeP1'];
      thursToP1 = thu['endTimeP1'];
      thursFromP2 = thu['startTimeP2'];
      thursToP2 = thu['endTimeP2'];
    } else {
      isThursOff = true;
    }

    // Friday
    if (worktime.bchworktimeFri != '') {
      Map<String, TimeOfDay?> fri =
          decodeTimeCustomMoreClean(worktime.bchworktimeFri!);
      friFromP1 = fri['startTimeP1'];
      friToP1 = fri['endTimeP1'];
      friFromP2 = fri['startTimeP2'];
      friToP2 = fri['endTimeP2'];
    } else {
      isFriOff = true;
    }
  }

  bool validateShiftTimings(TimeOfDay? startTimeP1, TimeOfDay? endTimeP1,
      TimeOfDay? startTimeP2, TimeOfDay? endTimeP2) {
    if (startTimeP1 == null || endTimeP1 == null) {
      // If any time is null, return false
      return false;
    }

    if (_isAfter(endTimeP1, startTimeP1) ||
        _isAfter(endTimeP2!, startTimeP2!)) {
      // End time must be after start time for both shifts
      return false;
    }

    if (_isBefore(startTimeP2, endTimeP1)) {
      // Start time of the second shift must be after end time of the first shift
      return false;
    }

    // All conditions passed, return true
    return true;
  }

  bool _isBefore(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour < time2.hour) {
      return true;
    } else if (time1.hour == time2.hour) {
      return time1.minute < time2.minute;
    }
    return false;
  }

  bool _isAfter(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour > time2.hour) {
      return true;
    } else if (time1.hour == time2.hour) {
      return time1.minute > time2.minute;
    }
    return false;
  }
}
