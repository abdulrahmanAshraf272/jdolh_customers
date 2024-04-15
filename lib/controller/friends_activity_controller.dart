import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';

class FriendsActivitiesController extends GetxController {
  ActivityData activityData = ActivityData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest likeStatusRequiest = StatusRequest.none;
  List<Activity> friendsActivities = [];
  //0 => friends activity,  1=> user rates  , 2=> my activity
  int pageStatus = 0;

  String appBarTitle() {
    switch (pageStatus) {
      case 0:
        return 'نشاطات الاصدقاء';
      case 1:
        return 'التقييمات';
      case 2:
        return 'النشاطات';
      default:
        return '';
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      friendsActivities = List.from(Get.arguments['activities']);
      if (Get.arguments['pageStatus'] != null) {
        pageStatus = Get.arguments['pageStatus'];
      }
    }
    super.onInit();
  }
}
