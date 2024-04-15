import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';

class HomeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusFriendsActivity = StatusRequest.none;
  MyServices myServices = Get.find();
  ActivityData activityData = ActivityData(Get.find());
  List<Activity> friendsActivities = [];

  gotoFriendsActivities() {
    Get.toNamed(AppRouteName.friendsActivities,
            arguments: {'activities': friendsActivities})!
        .then((value) => getFriendsActivities());
  }

  getFriendsActivities() async {
    statusFriendsActivity = StatusRequest.loading;
    update();
    var response =
        await activityData.getFriendsActivities(userid: myServices.getUserid());
    await Future.delayed(const Duration(seconds: lateDuration));
    statusFriendsActivity = handlingData(response);
    if (statusFriendsActivity == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parsingDataFromJsonToDartList(response) {
    List data = response['data'];
    friendsActivities = data.map((e) => Activity.fromJson(e)).toList();
  }

  @override
  void onInit() {
    getFriendsActivities();
    super.onInit();
  }
}
