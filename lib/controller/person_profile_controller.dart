import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/data_source/remote/person_profile.dart';
import 'package:jdolh_customers/data/data_source/remote/search_person.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/screens/person_profile_screen.dart';

class PersonProfileController extends GetxController {
  // StatusRequest statusRequest = StatusRequest.none;
  // PersonProfileData personProfileData = PersonProfileData(Get.find());
  // FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  // MyServices myServices = Get.find();
  // List<PersonWithFollowState> followers = [];
  // List<PersonWithFollowState> following = [];
  // late Person person;

  // getFollowersAndFollowing() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   followers.clear();
  //   following.clear();
  //   var response = await personProfileData.postData(person.userId.toString(),
  //       myServices.sharedPreferences.getString("id")!);
  //   statusRequest = handlingData(response);
  //   print('status ==== $statusRequest');
  //   if (statusRequest == StatusRequest.success) {
  //     if (response['status'] == 'success') {
  //       List responseFollowers = response['followers'];
  //       List responseFollowing = response['following'];
  //       //parsing jsonList to DartList.
  //       followers = responseFollowers
  //           .map((e) => PersonWithFollowState.fromJson(e))
  //           .toList();
  //       following = responseFollowing
  //           .map((e) => PersonWithFollowState.fromJson(e))
  //           .toList();
  //       print('followersNo: ${followers.length}');
  //       print('followingNo: ${following.length}');
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //   update();
  // }

  // goToFollwersAndFollowingScreen(bool isFollowers) {
  //   if (isFollowers) {
  //     //  String encodeList = jsonEncode(followers);
  //     // Get.toNamed(AppRouteName.followersAndFollowing,
  //     //     arguments: {"title": textFollowers, 'data': followers});
  //     Get.to(() =>
  //         FollowersAndFollowingScreen(title: textFollowers, data: followers));
  //   } else {
  //     //  String encodeList = jsonEncode(following);
  //     // Get.toNamed(AppRouteName.followersAndFollowing,
  //     //     arguments: {"title": textFollowing, 'data': following});
  //     Get.to(() =>
  //         FollowersAndFollowingScreen(title: textFollowing, data: following));
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   // person = Get.arguments;
  //   // getFollowersAndFollowing();
  // }
}
