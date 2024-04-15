import 'package:get/get.dart';

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
