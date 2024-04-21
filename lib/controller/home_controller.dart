import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/data_source/remote/trend.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/top_checkin.dart';

class HomeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusFriendsActivity = StatusRequest.none;
  StatusRequest statusTopRate = StatusRequest.none;
  StatusRequest statusTopCheckin = StatusRequest.none;
  StatusRequest statusTopRes = StatusRequest.none;
  StatusRequest statusOccasion = StatusRequest.none;

  MyServices myServices = Get.find();
  ActivityData activityData = ActivityData(Get.find());
  TrendData trendData = TrendData(Get.find());
  List<Activity> friendsActivities = [];
  List<Friend> topRate = [];
  List<TopCheckin> topCheckin = [];

  List<Brand> brands = [];
  List<Bch> bchs = [];
  OccasionsData occasionData = OccasionsData(Get.find());
  List<Occasion> occasionsToDisplay = [];
  List<Occasion> myOccasions = [];

  gotoFriendsActivities() {
    Get.toNamed(AppRouteName.friendsActivities,
            arguments: {'activities': friendsActivities})!
        .then((value) => getFriendsActivities());
  }

  getMyOccasion() async {
    statusOccasion = StatusRequest.loading;
    update();
    var response = await occasionData
        .viewOccasions(myServices.sharedPreferences.getString("id")!);
    await Future.delayed(const Duration(seconds: lateDuration));
    statusOccasion = handlingData(response);
    update();
    print('status ==== $statusOccasion');
    if (statusOccasion == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingOccasion(response);
        print('occasions: ${myOccasions.length}');
      } else {
        //statusRequest = StatusRequest.failure;
      }
    }
  }

  parsingOccasion(response) {
    List responseOccasoins = response['data'];
    myOccasions = responseOccasoins.map((e) => Occasion.fromJson(e)).toList();
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

  goToOccasionsScreen() {
    Get.toNamed(AppRouteName.occasions);
  }

  getTopRate() async {
    statusTopRate = StatusRequest.loading;
    update();
    var response = await trendData.getTopRate(myServices.getUserid());
    await Future.delayed(const Duration(seconds: lateDuration));
    statusTopRate = handlingData(response);
    if (statusTopRate == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        topRate = data.map((e) => Friend.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  getTopCheckin() async {
    statusTopCheckin = StatusRequest.loading;
    update();
    var response = await trendData.getTopCheckin();
    await Future.delayed(const Duration(seconds: lateDuration));
    statusTopCheckin = handlingData(response);
    if (statusTopCheckin == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        topCheckin = data.map((e) => TopCheckin.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  getTopRes() async {
    statusTopRes = StatusRequest.loading;
    update();
    var response = await trendData.getTopRes();
    await Future.delayed(const Duration(seconds: lateDuration));
    statusTopRes = handlingData(response);
    if (statusTopRes == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        brands = data.map((e) => Brand.fromJson(e)).toList();
        bchs = data.map((e) => Bch.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
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

  gotoExploreBrand() {
    Get.toNamed(AppRouteName.exploreBrand,
        arguments: {"brands": brands, "bchs": bchs});
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

  @override
  void onInit() {
    getFriendsActivities();
    getTopCheckin();
    getTopRate();
    getTopRes();
    getMyOccasion();
    super.onInit();
  }
}
