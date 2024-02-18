import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/person_profile_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/data/models/person.dart';
import 'package:jdolh_customers/data/models/person_with_follow_state.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
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
  PersonProfileData personProfileData = PersonProfileData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  MyServices myServices = Get.find();
  List<Friend> followers = [];
  List<Friend> following = [];
  late Friend person;

  getFollowersAndFollowing() async {
    statusRequest = StatusRequest.loading;
    setState(() {});
    followers.clear();
    following.clear();
    var response = await personProfileData.postData(person.userId.toString(),
        myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    print('status ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List responseFollowers = response['followers'];
        List responseFollowing = response['following'];
        //parsing jsonList to DartList.
        followers = responseFollowers.map((e) => Friend.fromJson(e)).toList();
        following = responseFollowing.map((e) => Friend.fromJson(e)).toList();
        print('followersNo: ${followers.length}');
        print('followingNo: ${following.length}');
      } else {
        statusRequest = StatusRequest.failure;
        print('getFollowersAndFollowing failed');
      }
    }
    setState(() {});
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init state ================');
    final controller = Get.put(PersonProfileController());
    person = Get.arguments;
    getFollowersAndFollowing();
  }

  @override
  Widget build(BuildContext context) {
    print('calling function');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: GetBuilder<PersonProfileController>(
        builder: (controller) => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/avatar_person.jpg',
                fit: BoxFit.cover,
                height: 80.h,
                width: 80.w,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              person.userName!,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              person.userUsername!,
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
                      number: 120,
                      onTap: () {},
                      iconData: Icons.comment,
                      buttonColor: AppColors.redProfileButton),
                ),
                const SizedBox(width: 15),
              ],
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: 12,
                itemBuilder: (context, index) => CommentListItem(),
                separatorBuilder: (context, index) => Container(
                  color: AppColors.gray450,
                  height: 2,
                  width: Get.width,
                ), // Add separatorBuilder
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      )),
    );
  }
}
