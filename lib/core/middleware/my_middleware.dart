import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    String step = myServices.sharedPreferences.getString('step') ?? '0';
    if (step == '2') {
      return const RouteSettings(name: AppRouteName.mainScreen);
    }
    if (step == '1') {
      return const RouteSettings(name: AppRouteName.login);
    }
  }
}
