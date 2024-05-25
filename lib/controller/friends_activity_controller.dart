import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
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

  onTapLike(int index) {
    if (friendsActivities[index].isLiked == 1) {
      likeUnlikeActivity(
          friendsActivities[index].type!, friendsActivities[index].id!, 0);
      friendsActivities[index].isLiked = 0;
      friendsActivities[index].likesNo = friendsActivities[index].likesNo! - 1;
    } else {
      likeUnlikeActivity(
          friendsActivities[index].type!, friendsActivities[index].id!, 1);
      friendsActivities[index].isLiked = 1;
      friendsActivities[index].likesNo = friendsActivities[index].likesNo! + 1;
      NotificationSender.sendFollowingPersonLikeActivity(
          friendsActivities[index].userid,
          int.parse(myServices.getUserid()),
          myServices.getName(),
          myServices.getImage(),
          friendsActivities[index].type!);
    }
    update();
  }

  likeUnlikeActivity(String activityType, int activityId, int like) async {
    var response = await activityData.likeUnlikeActivity(
        userid: myServices.getUserid(),
        activityType: activityType,
        activityId: activityId.toString(),
        like: like.toString());
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('like/unlike success');
      } else {
        print('like/unlike failure');
      }
    }
  }

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
