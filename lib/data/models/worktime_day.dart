import 'package:flutter/material.dart';

class WorktimeDay {
  TimeOfDay startTimeP1;
  TimeOfDay endTimeP1;
  TimeOfDay? startTimeP2;
  TimeOfDay? endTimeP2;

  WorktimeDay(
      {required this.startTimeP1,
      required this.endTimeP1,
      this.startTimeP2,
      this.endTimeP2});
}
