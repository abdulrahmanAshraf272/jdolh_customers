import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/is_date_passed.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/data_source/remote/ad.dart';
import 'package:jdolh_customers/data/data_source/remote/occasions.dart';
import 'package:jdolh_customers/data/data_source/remote/trend.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/ad.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/occasion.dart';
import 'package:jdolh_customers/data/models/top_checkin.dart';

class HomeController extends GetxController {
  StatusRequest statusAds = StatusRequest.none;
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusFriendsActivity = StatusRequest.none;
  StatusRequest statusTopRate = StatusRequest.none;
  StatusRequest statusTopCheckin = StatusRequest.none;
  StatusRequest statusTopRes = StatusRequest.none;
  StatusRequest statusOccasion = StatusRequest.none;

  MyServices myServices = Get.find();
  ActivityData activityData = ActivityData(Get.find());
  TrendData trendData = TrendData(Get.find());
  AdData adData = AdData(Get.find());
  List<Ad> adsBeforeFilter = [];
  List<Ad> ads = [];
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

  Future getMyOccasion() async {
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
        print('occasions: ${occasionsToDisplay.length}');
      } else {
        //statusRequest = StatusRequest.failure;
      }
    }
  }

  parsingOccasion(response) {
    myOccasions.clear();
    occasionsToDisplay.clear();
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

  Future getTopRate() async {
    statusTopRate = StatusRequest.loading;
    update();
    var response = await trendData.getTopRate(myServices.getUserid());
    await Future.delayed(const Duration(seconds: lateDuration));
    statusTopRate = handlingData(response);
    if (statusTopRate == StatusRequest.success) {
      if (response['status'] == 'success') {
        topRate.clear();
        List data = response['data'];
        topRate = data.map((e) => Friend.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  Future getTopCheckin() async {
    statusTopCheckin = StatusRequest.loading;
    update();
    var response = await trendData.getTopCheckin();
    await Future.delayed(const Duration(seconds: lateDuration));
    statusTopCheckin = handlingData(response);
    if (statusTopCheckin == StatusRequest.success) {
      if (response['status'] == 'success') {
        topCheckin.clear();
        List data = response['data'];
        topCheckin = data.map((e) => TopCheckin.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  Future getTopRes() async {
    statusTopRes = StatusRequest.loading;
    update();
    var response = await trendData.getTopRes();
    await Future.delayed(const Duration(seconds: lateDuration));
    statusTopRes = handlingData(response);
    if (statusTopRes == StatusRequest.success) {
      if (response['status'] == 'success') {
        brands.clear();
        bchs.clear();
        List data = response['data'];
        brands = data.map((e) => Brand.fromJson(e)).toList();
        bchs = data.map((e) => Bch.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  Future getFriendsActivities() async {
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

  getAds() async {
    statusAds = StatusRequest.loading;
    update();
    var response = await adData.getAllAds();
    statusAds = handlingData(response);
    print('ads status: $statusAds');
    if (statusAds == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseAds(response);
      } else {
        statusAds = StatusRequest.failure;
      }
    }
    update();
  }

  parseAds(response) {
    adsBeforeFilter.clear();
    ads.clear();
    List data = response['data'];
    adsBeforeFilter = data.map((e) => Ad.fromJson(e)).toList();

    for (int i = 0; i < adsBeforeFilter.length; i++) {
      if (adsBeforeFilter[i].active == 1) {
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
    print('ads before filter: ${adsBeforeFilter.length}');
    print('ads after filter: ${ads.length}');
  }

  parsingDataFromJsonToDartList(response) {
    friendsActivities.clear();
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

  Future<void> getAllData() async {
    try {
      getFriendsActivities();
      getTopCheckin();
      getTopRate();
      getTopRes();
      getMyOccasion();
      getAds();
    } catch (error) {
      throw error;
    }
  }

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }
}
