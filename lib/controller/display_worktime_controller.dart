import 'package:get/get.dart';
import 'package:jdolh_customers/controller/allTimesMixin.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/models/bch_worktime.dart';

class DisplayWorktimeController extends GetxController with AllTimes {
  late BchWorktime worktime;

  @override
  void onInit() {
    if (Get.arguments != null) {
      worktime = Get.arguments;
    }

    decodeFromStringToTimeOfDay(worktime);
    super.onInit();
  }
}
