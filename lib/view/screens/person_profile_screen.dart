import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/person_profile_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/const_int.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/comment.dart';
import 'package:jdolh_customers/view/widgets/more_screen/rect_button.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/followUnfollow.dart';
import 'package:jdolh_customers/data/data_source/remote/person_profile.dart';

class PersonProfile extends StatefulWidget {
  const PersonProfile({super.key});

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusFriendsActivity = StatusRequest.none;
  PersonProfileData personProfileData = PersonProfileData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  ActivityData activityData = ActivityData(Get.find());
  List<Activity> friendsActivities = [];
  List<Activity> onlyRatesActivities = [];
  MyServices myServices = Get.find();
  List<Friend> followers = [];
  List<Friend> following = [];
  late Friend friend;

  String image = '';

  getFollowersAndFollowing() async {
    statusRequest = StatusRequest.loading;
    setState(() {});
    followers.clear();
    following.clear();
    var response = await personProfileData.postData(friend.userId.toString(),
        myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseData(response);
      } else {
        statusRequest = StatusRequest.failure;
        print('getFollowersAndFollowing failed');
      }
    }
    setState(() {});
  }

  parseData(response) {
    List responseFollowers = response['followers'];
    List responseFollowing = response['following'];
    //parsing jsonList to DartList.
    followers = responseFollowers.map((e) => Friend.fromJson(e)).toList();
    following = responseFollowing.map((e) => Friend.fromJson(e)).toList();
    print('followersNo: ${followers.length}');
    print('followingNo: ${following.length}');
  }

  getUserActivities() async {
    setState(() {
      statusFriendsActivity = StatusRequest.loading;
    });
    var response = await activityData.getUserActivities(
        userid: friend.userId.toString(), myId: myServices.getUserid());
    await Future.delayed(const Duration(seconds: lateDuration));
    statusFriendsActivity = handlingData(response);
    if (statusFriendsActivity == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
      } else {
        print('failure');
      }
    }
    setState(() {});
  }

  parsingDataFromJsonToDartList(response) {
    List data = response['data'];
    friendsActivities = data.map((e) => Activity.fromJson(e)).toList();

    onlyRatesActivities = List.from(friendsActivities);
    onlyRatesActivities.removeWhere((element) => element.type != 'rate');
  }

  goToFollwersAndFollowingScreen(bool isFollowers) {
    if (isFollowers) {
      //  String encodeList = jsonEncode(followers);
      // Get.toNamed(AppRouteName.followersAndFollowing,
      //     arguments: {"title": textFollowers, 'data': followers});
      Get.to(() =>
          FollowersAndFollowingScreen(title: textFollowers, data: followers));
    } else {
      //  String encodeList = jsonEncode(following);
      // Get.toNamed(AppRouteName.followersAndFollowing,
      //     arguments: {"title": textFollowing, 'data': following});
      Get.to(() =>
          FollowersAndFollowingScreen(title: textFollowing, data: following));
    }
  }

  onTapLike(int index) {
    if (friendsActivities[index].isLiked == 1) {
      likeUnlikeActivity(
          friendsActivities[index].type!, friendsActivities[index].id!, 0);
      friendsActivities[index].isLiked = 0;
    } else {
      likeUnlikeActivity(
          friendsActivities[index].type!, friendsActivities[index].id!, 1);
      friendsActivities[index].isLiked = 1;
    }
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

  gotoFriendsActivities() {
    Get.toNamed(AppRouteName.friendsActivities,
            arguments: {'activities': onlyRatesActivities, "pageStatus": 1})!
        .then((value) => getUserActivities());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init state ================');
    //final controller = Get.put(PersonProfileController());
    friend = Get.arguments;
    image = friend.userImage ?? '';
    getFollowersAndFollowing();
    getUserActivities();
  }

  @override
  Widget build(BuildContext context) {
    print('calling function');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: image != ''
                  ? FadeInImage.assetNetwork(
                      height: 80.h,
                      width: 80.w,
                      placeholder: 'assets/images/loading2.gif',
                      image: '${ApiLinks.customerImage}/$image',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/person4.jpg',
                      fit: BoxFit.cover,
                      height: 80.h,
                      width: 80.w,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              friend.userName!,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              friend.userUsername!,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.6)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: RectButton(
                      text: 'متابعين',
                      number: followers.length,
                      onTap: () {
                        goToFollwersAndFollowingScreen(true);
                      },
                      iconData: Icons.group,
                      buttonColor: AppColors.green),
                ),
                Expanded(
                  child: RectButton(
                      text: 'متابعون',
                      number: following.length,
                      onTap: () {
                        goToFollwersAndFollowingScreen(false);
                      },
                      iconData: Icons.groups,
                      buttonColor: AppColors.yellow),
                ),
                Expanded(
                  child: RectButton(
                      text: 'التقييم',
                      number: onlyRatesActivities.length,
                      onTap: () {
                        gotoFriendsActivities();
                      },
                      iconData: Icons.comment,
                      buttonColor: AppColors.redProfileButton),
                ),
                const SizedBox(width: 15),
              ],
            ),
            HandlingDataView(
              statusRequest: statusFriendsActivity,
              widget: Expanded(
                child: friendsActivities.isEmpty
                    ? const Center(child: Text('لا يوجد نشاطات'))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: friendsActivities.length,
                        itemBuilder: (context, index) => ActivityListItem(
                              cardStatus: 1,
                              activity: friendsActivities[index],
                              onTapLike: () {
                                if (friendsActivities[index].isLiked == 1) {
                                  friendsActivities[index].isLiked = 0;
                                } else {
                                  friendsActivities[index].isLiked = 1;
                                }
                              },
                            )),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
