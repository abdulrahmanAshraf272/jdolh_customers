import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/view/screens/appt_details_screen.dart';
import 'package:jdolh_customers/view/screens/appt_screen.dart';
import 'package:jdolh_customers/view/screens/create_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/more_screen.dart';
import 'package:jdolh_customers/view/screens/schedule_screen.dart';

class MainController extends GetxController {
  int currentPage = 0;
  List<Widget> listPage = [
    const HomeScreen(),
    const ScheduleScreen(),
    const CreateOccasionScreen(),
    const MoreScreen()
  ];
  @override
  changePage(int i) {
    currentPage = i;
    update();
  }
}
