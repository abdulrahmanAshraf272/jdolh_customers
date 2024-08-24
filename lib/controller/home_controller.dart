import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/is_date_passed.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/data_source/remote/ad.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/ad.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/policy.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:jdolh_customers/data/models/top_checkin.dart';

class HomeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();
  ActivityData activityData = ActivityData(Get.find());
  AdData adData = AdData(Get.find());

  List<Ad> ads = [];
  List<Activity> friendsActivities = [];
  List<Friend> topRate = [];
  List<TopCheckin> topCheckin = [];

  List<Brand> brands = [];
  List<Bch> bchs = [];

  List<Reservation> reservation = [];

  List<Reservation> suspendedReservation = [];

  List<Occasion> occasionsToDisplay = [];

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
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('like/unlike success');
      } else {
        print('like/unlike failure');
      }
    }
  }

  Future getHomseScreenData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await activityData.getHomeScreenData(userid: myServices.getUserid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print(response['topRate']);
        parseFriendsActivities(response);
        parseAds(response);
        parseTopCheckin(response);
        parseTopRate(response);
        parseTopRes(response);
        parseOccasion(response);
        parseReservations(response);
        parseSuspendedReservations(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  goToWaitApprovalScreen(int index) {
    Policy resPolicy = Policy(
        id: suspendedReservation[index].resResPolicy,
        title: suspendedReservation[index].resPolicyTitle);
    Policy billPolicy = Policy(
        id: suspendedReservation[index].resBillPolicy,
        title: suspendedReservation[index].billPolicyTitle);

    Get.toNamed(AppRouteName.waitForApprove, arguments: {
      "res": suspendedReservation[index],
      "resPolicy": resPolicy,
      "billPolicy": billPolicy
    });
  }

  parseSuspendedReservations(response) {
    suspendedReservation.clear();
    List data = response['suspendedRes'];
    suspendedReservation = data.map((e) => Reservation.fromJson(e)).toList();
  }

  parseReservations(response) {
    reservation.clear();
    List reservationData = response['reservation'];
    List<Reservation> res =
        reservationData.map((e) => Reservation.fromJson(e)).toList();
    for (int i = 0; i < res.length; i++) {
      if (res[i].resStatus == 3) {
        //String datetime = '${res[i].resDate} ${res[i].resTime}';

        if (!isDatePassed(res[i].resDate!)) {
          reservation.add(res[i]);
        }
      }
    }
  }

  parseFriendsActivities(response) {
    friendsActivities.clear();
    List friendsActivitiesData = response['friendsActivities'];
    friendsActivities =
        friendsActivitiesData.map((e) => Activity.fromJson(e)).toList();
  }

  parseAds(response) {
    ads.clear();
    List adsData = response['ads'];
    List<Ad> adsBeforeFilter = adsData.map((e) => Ad.fromJson(e)).toList();

    for (int i = 0; i < adsBeforeFilter.length; i++) {
      if (adsBeforeFilter[i].endData != null) {
        if (!isDatePassed(adsBeforeFilter[i].endData!)) {
          ads.add(adsBeforeFilter[i]);
        }
      } else {
        //if endDate is null it means it is unlimited ad
        ads.add(adsBeforeFilter[i]);
      }
    }
  }

  parseTopCheckin(response) {
    topCheckin.clear();
    List topCheckinData = response['topCheckin'];
    topCheckin = topCheckinData.map((e) => TopCheckin.fromJson(e)).toList();
  }

  parseTopRate(response) {
    topRate.clear();
    List topRateData = response['topRate'];
    topRate = topRateData.map((e) => Friend.fromJson(e)).toList();
  }

  parseTopRes(response) {
    brands.clear();
    bchs.clear();
    List topResData = response['topRes'];
    brands = topResData.map((e) => Brand.fromJson(e)).toList();
    bchs = topResData.map((e) => Bch.fromJson(e)).toList();
  }

  parseOccasion(response) {
    occasionsToDisplay.clear();
    List occasionsData = response['occasions'];
    List<Occasion> myOccasions =
        occasionsData.map((e) => Occasion.fromJson(e)).toList();
    List<Occasion> occasionInFuture =
        filterAndOrderOccasionInFuture(myOccasions);
    for (var element in occasionInFuture) {
      if (element.acceptstatus == 1) {
        occasionsToDisplay.add(element);
      }
    }
    update();
  }

  List<Occasion> filterAndOrderOccasionInFuture(List<Occasion> myOccasions) {
    final now = DateTime.now();
    List<Occasion> futureOccasions = [];

    for (var occasion in myOccasions) {
      DateTime occasionDateTime =
          DateTime.parse('${occasion.occasionDate} ${occasion.occasionTime}');
      if (occasionDateTime.isAfter(now)) {
        futureOccasions.add(occasion);
      }
    }

    futureOccasions.sort((a, b) {
      DateTime aDateTime =
          DateTime.parse('${a.occasionDate} ${a.occasionTime}');
      DateTime bDateTime =
          DateTime.parse('${b.occasionDate} ${b.occasionTime}');
      return aDateTime.compareTo(bDateTime); // Sort sooner first
    });

    return futureOccasions;
  }

  // onTapOccasionCard(int index) {
  //   if (occasionsToDisplay[index].creator == 1) {
  //     Get.toNamed(AppRouteName.editOccasion,
  //             arguments: occasionsToDisplay[index])!
  //         .then((value) => getMyOccasion());
  //   } else {
  //     Get.toNamed(AppRouteName.occasionDetails,
  //             arguments: occasionsToDisplay[index])!
  //         .then((value) => getMyOccasion());
  //   }
  // }

  gotoExploreBrand() {
    Get.toNamed(AppRouteName.exploreBrand,
        arguments: {"brands": brands, "bchs": bchs});
  }

  gotoReservations() {
    Get.toNamed(AppRouteName.schedule);
  }

  gotoFriendsActivities() {
    Get.toNamed(AppRouteName.friendsActivities,
        arguments: {'activities': friendsActivities});
  }

  gotoBrand(int index) {
    Get.toNamed(AppRouteName.brandProfile,
        arguments: {"brand": brands[index], "bch": bchs[index]});
  }

  gotoPersonProfile(int index) {
    Get.toNamed(AppRouteName.personProfile, arguments: topRate[index]);
  }

  gotoShowAllTopRate() {
    Get.toNamed(AppRouteName.explorePeople, arguments: topRate);
  }

  gotoExploreCheckin() {
    Get.toNamed(AppRouteName.exploreCheckin, arguments: topCheckin);
  }

  onTapAd(int index) {
    increaseClickCount(index);
    gotoAdProfile(index);
  }

  gotoAdProfile(int index) {
    int? bchid = ads[index].bchId;
    if (bchid != null) {
      Get.toNamed(AppRouteName.brandProfile,
          arguments: {"fromActivity": true, "bchid": bchid});
    }
  }

  goToOccasionsScreen() {
    Get.toNamed(AppRouteName.occasions);
  }

  increaseClickCount(int index) async {
    var response =
        await adData.increaseClickNumber(adId: ads[index].adsId.toString());
    StatusRequest status = handlingData(response);
    print('ads status: $status');
    if (status == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('click number increase');
      } else {
        print('failure: ${response['message']}');
      }
    }
  }

  @override
  void onInit() {
    getHomseScreenData();
    super.onInit();
  }
}
