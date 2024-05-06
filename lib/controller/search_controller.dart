import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/notification/notification_subscribtion.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/data_source/remote/search_person.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/brand_and_bch.dart';
import 'package:jdolh_customers/data/models/friend.dart';

class SearchScreenController extends GetxController {
  bool isPersonSearch = true;
  StatusRequest statusRequest = StatusRequest.none;
  SearchPersonData searchPersonData = SearchPersonData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  TextEditingController name = TextEditingController();
  //List<Friend> data = [];
  ValuesController valuesController = Get.put(ValuesController());

  List<Friend> allUsers = [];
  List<Friend> usersSearched = [];

  List<BrandAndBch> brandAndBch = [];
  List<BrandAndBch> brandAndBchSearched = [];

  List<Brand> brands = [];
  List<Bch> bchs = [];

  onTapUser(int index) {
    Get.toNamed(AppRouteName.personProfile, arguments: usersSearched[index])!
        .then((value) => update());
  }

  onTapStore(int index) {
    Brand brand = brands.firstWhere(
        (element) => element.brandId == brandAndBchSearched[index].brandId);
    Bch bch = bchs.firstWhere(
        (element) => element.bchId == brandAndBchSearched[index].bchId);
    Get.toNamed(AppRouteName.brandProfile, arguments: {
      "brand": brand,
      "bch": bch,
    });
  }

  activePersonSearch() {
    isPersonSearch = true;
    name.clear();
    usersSearched = List.of(allUsers);
    brandAndBchSearched.clear();
    update();
  }

  inactivePersonSearch() {
    isPersonSearch = false;
    name.clear();
    usersSearched.clear();
    brandAndBchSearched = List.of(brandAndBch);
    if (brandAndBch.isEmpty) {
      getAllStores();
    }
    update();
  }

  seachOnTap(String? value) {
    // getPeopleSearchedFor(value);
    if (value != null) {
      if (isPersonSearch) {
        usersSearched = allUsers
            .where((element) =>
                element.userUsername!.contains(value) ||
                element.userName!.contains(value))
            .toList();
      } else {
        brandAndBchSearched = brandAndBch
            .where((element) => element.brandStoreName!.contains(value))
            .toList();
      }

      update();
    }
  }

  getAllUsers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await followUnfollowData.getAllUsers(myId: myServices.getUserid());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        allUsers = data.map((e) => Friend.fromJson(e)).toList();

        //Remove my self from all user
        allUsers.removeWhere(
            (element) => element.userId.toString() == myServices.getUserid());

        usersSearched = List.of(allUsers);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getAllStores() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await followUnfollowData.getAllStores();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        brandAndBch = data.map((e) => BrandAndBch.fromJson(e)).toList();
        brandAndBchSearched = List.of(brandAndBch);

        //For onTapStore
        brands = data.map((e) => Brand.fromJson(e)).toList();
        bchs = data.map((e) => Bch.fromJson(e)).toList();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  followUnfollow(int index) {
    followUnfollowRequest(usersSearched[index].userId.toString());
    valuesController.addAndRemoveFollowing(usersSearched[index]);
    if (usersSearched[index].following!) {
      usersSearched[index].following = false;
      NotificationSubscribtion.unfollowUserSubcribeToTopic(
          usersSearched[index].userId);
    } else {
      usersSearched[index].following = true;
      NotificationSubscribtion.followUserSubcribeToTopic(
          usersSearched[index].userId);
      NotificationSender.sendFollowingPerson(
          usersSearched[index].userId,
          int.parse(myServices.getUserid()),
          myServices.getName(),
          myServices.getImage());
    }
    update();
  }

  followUnfollowRequest(String personId) async {
    var response = await followUnfollowData.postData(
        myServices.sharedPreferences.getString("id")!, personId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('operation followUnfollow done succussfuly');
      } else {
        print('operation followUnfollow done failed');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
  }

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }
}
