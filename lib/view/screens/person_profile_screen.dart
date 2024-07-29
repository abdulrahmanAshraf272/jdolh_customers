import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/notification/notification_subscribtion.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/friend.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
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
  StatusRequest statusGetUser = StatusRequest.none;

  StatusRequest statusFriendsActivity = StatusRequest.none;
  PersonProfileData personProfileData = PersonProfileData(Get.find());
  FollowUnfollowData followUnfollowData = FollowUnfollowData(Get.find());
  ActivityData activityData = ActivityData(Get.find());
  List<Activity> friendsActivities = [];
  List<Activity> onlyRatesActivities = [];
  MyServices myServices = Get.find();
  ValuesController valuesController = Get.put(ValuesController());
  List<Friend> followers = [];
  List<Friend> following = [];
  Friend? friend;

  String image = '';

  Future getFollowersAndFollowing() async {
    print('id: ${friend!.userId.toString()}');

    // statusRequest = StatusRequest.loading;
    // setState(() {});
    followers.clear();
    following.clear();
    var response = await personProfileData.postData(friend!.userId.toString(),
        myServices.sharedPreferences.getString("id")!);
    statusRequest = handlingData(response);
    print('getFollowersAndFollowing ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseData(response);
      } else {
        statusRequest = StatusRequest.failure;
        print('getFollowersAndFollowing failed');
      }
    }
    //setState(() {});
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

  Future getUserActivities() async {
    var response = await activityData.getUserActivities(
        userid: friend!.userId.toString(), myId: myServices.getUserid());

    statusFriendsActivity = handlingData(response);
    print('statusFriendsActivity $statusFriendsActivity');
    if (statusFriendsActivity == StatusRequest.success) {
      if (response['status'] == 'success') {
        parsingDataFromJsonToDartList(response);
      } else {
        print('failure');
      }
    }
    //setState(() {});
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
          FollowersAndFollowingScreen(title: 'المتابعين'.tr, data: followers));
    } else {
      //  String encodeList = jsonEncode(following);
      // Get.toNamed(AppRouteName.followersAndFollowing,
      //     arguments: {"title": textFollowing, 'data': following});
      Get.to(() =>
          FollowersAndFollowingScreen(title: 'المتابعون'.tr, data: following));
    }
  }

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
          friend!.userId!,
          int.parse(myServices.getUserid()),
          myServices.getName(),
          myServices.getImage(),
          friendsActivities[index].type!);
    }
    setState(() {});
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

  followUnfollow() {
    followUnfollowRequest(friend!.userId.toString());
    valuesController.addAndRemoveFollowing(friend!);
    if (friend!.following!) {
      friend!.following = false;
      NotificationSubscribtion.unfollowUserSubcribeToTopic(friend!.userId);
    } else {
      friend!.following = true;
      NotificationSubscribtion.followUserSubcribeToTopic(friend!.userId);

      NotificationSender.sendFollowingPerson(
          friend!.userId,
          int.parse(myServices.getUserid()),
          myServices.getName(),
          myServices.getImage());
    }
    setState(() {});
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

  getUser(userid) async {
    statusGetUser = StatusRequest.loading;
    setState(() {});
    print(userid.runtimeType);
    print(userid);
    print('===============');
    var response = await personProfileData.getUserData(
        myId: myServices.getUserid(), userid: userid.toString());
    statusGetUser = handlingData(response);
    print('statusGetUser $statusGetUser');
    if (statusGetUser == StatusRequest.success) {
      if (response['status'] == 'success') {
        friend = Friend.fromJson(response['data']);
        print('====================su');
      } else {
        statusGetUser = StatusRequest.failure;
      }
    }
    setState(() {});
  }

  void getUserFollowersAndActivities() async {
    setState(() {
      statusFriendsActivity = StatusRequest.loading;
    });
    await Future.wait([
      getFollowersAndFollowing(),
      getUserActivities(),
    ]);
    setState(() {});
    print('shit');
  }

  receiveData() async {
    dynamic argument = Get.arguments;

    if (argument is Friend) {
      print('====================1');
      friend = Get.arguments;
      setState(() {});
    } else {
      print('====================2');
      await getUser(argument);
    }

    image = friend!.userImage ?? '';
    getUserFollowersAndActivities();
  }

  @override
  void initState() {
    receiveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: statusGetUser != StatusRequest.success && friend == null
            ? HandlingDataView2(statusRequest: statusGetUser)
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: image != ''
                                  ? FadeInImage.assetNetwork(
                                      height: 70.h,
                                      width: 70.w,
                                      placeholder: 'assets/images/loading2.gif',
                                      image: '${ApiLinks.customerImage}/$image',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/person4.jpg',
                                      fit: BoxFit.cover,
                                      height: 70.h,
                                      width: 70.w,
                                    ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 3),
                                  AutoSizeText(
                                    friend!.userName ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    friend!.userUsername!,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      FollowButton(
                          onTap: () => followUnfollow(),
                          following: friend!.following!),
                      const SizedBox(width: 20)
                    ],
                  ),

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(100),
                  //   child: image != ''
                  //       ? FadeInImage.assetNetwork(
                  //           height: 80.h,
                  //           width: 80.w,
                  //           placeholder: 'assets/images/loading2.gif',
                  //           image: '${ApiLinks.customerImage}/$image',
                  //           fit: BoxFit.cover,
                  //         )
                  //       : Image.asset(
                  //           'assets/images/person4.jpg',
                  //           fit: BoxFit.cover,
                  //           height: 80.h,
                  //           width: 80.w,
                  //         ),
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   friend.userName!,
                  //   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  // ),
                  // Text(
                  //   friend.userUsername!,
                  //   style: TextStyle(
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.black.withOpacity(0.6)),
                  // ),
                  const SizedBox(height: 20),
                  HandlingDataView(
                      statusRequest: statusFriendsActivity,
                      widget: Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 15),
                                Expanded(
                                  child: RectButton(
                                      text: 'متابعين'.tr,
                                      number: followers.length,
                                      onTap: () {
                                        goToFollwersAndFollowingScreen(true);
                                      },
                                      iconData: Icons.group,
                                      buttonColor: AppColors.green),
                                ),
                                Expanded(
                                  child: RectButton(
                                      text: 'متابعون'.tr,
                                      number: following.length,
                                      onTap: () {
                                        goToFollwersAndFollowingScreen(false);
                                      },
                                      iconData: Icons.groups,
                                      buttonColor: AppColors.yellow),
                                ),
                                Expanded(
                                  child: RectButton(
                                      text: 'التقييم'.tr,
                                      number: onlyRatesActivities.length,
                                      onTap: () {
                                        gotoFriendsActivities();
                                      },
                                      iconData: Icons.comment,
                                      buttonColor: AppColors.blue2),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                            Expanded(
                              child: friendsActivities.isEmpty
                                  ? Center(child: Text('لا يوجد نشاطات'.tr))
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: friendsActivities.length,
                                      itemBuilder: (context, index) =>
                                          ActivityListItem(
                                            cardStatus: 1,
                                            activity: friendsActivities[index],
                                            onTapLike: () {
                                              onTapLike(index);
                                            },
                                          )),
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  final void Function() onTap;

  final bool following;
  const FollowButton({super.key, required this.onTap, required this.following});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(15.0),
          right: Radius.circular(15.0),
        ),
        color: following
            ? AppColors.redProfileButton
            : AppColors.secondaryColor, // Border color
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(15.0),
          right: Radius.circular(15.0),
        ),
        child: Material(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(15.0),
            right: Radius.circular(15.0),
          ),
          color: Colors.transparent, // Transparent background
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              width: 80.w,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: AutoSizeText(
                maxLines: 1,
                minFontSize: 6,
                following ? 'الغاء المتابعة'.tr : 'متابعة'.tr,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
