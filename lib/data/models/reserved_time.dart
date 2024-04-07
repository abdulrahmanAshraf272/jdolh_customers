import 'package:flutter/material.dart';

class ReservedTime {
  String? resDate;
  String? resTime;
  int? resDuration;
  int? count;
  //List<TimeOfDay>? reservedTimes;

  ReservedTime({
    this.resDate,
    this.resTime,
    this.resDuration,
    this.count,
    //this.reservedTimes,
  });

  ReservedTime.fromJson(Map<String, dynamic> json) {
    resDate = json['res_date'];
    resTime = json['res_time'];
    resDuration = json['res_duration'];
    count = json['count'];
  }
}
