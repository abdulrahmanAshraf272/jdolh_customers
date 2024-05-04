import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/values_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_subscribtion.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/widgets/more_screen/rect_button.dart';
import 'package:jdolh_customers/view/widgets/more_screen/settings_button.dart';

import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/data/models/friend.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  StatusRequest statusFriendsActivity = StatusRequest.none;
  ActivityData activityData = ActivityData(Get.find());
  List<Activity> myActivities = [];
  String image = '';
  String name = '';
  String username = '';
  MyServices myServices = Get.find();
  ValuesController valuesController = Get.put(ValuesController());
  List<Friend> myfollowers = [];
  List<Friend> myfollowing = [];

  logout() {
    Get.defaultDialog(
        title: 'تسجيل خروج',
        middleText: 'هل تريد تسجيل الخروج؟',
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppRouteName.login);
              NotificationSubscribtion.userUnsubscribeToTopic(
                int.parse(myServices.getUserid()),
                myServices.getCity(),
                int.parse(myServices.getGender()),
              );
              myServices.sharedPreferences.setString("step", "1");
            },
            child: const Text('نعم'),
          ),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('الغاء'))
        ]);
  }

  gotoFollowers() {
    Get.to(() =>
            FollowersAndFollowingScreen(title: 'متابعين', data: myfollowers))!
        .then((value) => getFollowersFollowingFromValuesController());
  }

  gotoFollowing() {
    Get.to(() =>
            FollowersAndFollowingScreen(title: 'متابعون', data: myfollowing))!
        .then((value) => getFollowersFollowingFromValuesController());
  }

  getUserActivities() async {
    var response = await activityData.getUserActivities(
        userid: myServices.getUserid(), myId: myServices.getUserid());
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
    myActivities = data.map((e) => Activity.fromJson(e)).toList();
  }

  gotoFriendsActivities() {
    Get.toNamed(AppRouteName.friendsActivities,
        arguments: {'activities': myActivities, "pageStatus": 2});
  }

  getFollowersFollowingFromValuesController() {
    print('hello from getFollowersFollowing');
    myfollowers = List.from(valuesController.myfollowers);
    myfollowing = List.from(valuesController.myfollowing);
    print(myfollowing.length);
    setState(() {});
  }

  @override
  void initState() {
    image = myServices.getImage();
    name = myServices.getName();
    username = myServices.getUsername();
    getUserActivities();
    getFollowersFollowingFromValuesController();
    print('hello from more screen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: customAppBar(title: 'الفواتير'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: SizedBox()),
            CircleAvatar(
              radius: Get.width / 6, // Adjust as needed
              backgroundImage: image != ''
                  ? NetworkImage('${ApiLinks.customerImage}/${image}')
                  : const AssetImage('assets/images/person4.jpg')
                      as ImageProvider,
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              username,
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
                      number: myfollowers.length,
                      onTap: () {
                        gotoFollowers();
                      },
                      iconData: Icons.group,
                      buttonColor: AppColors.green),
                ),
                Expanded(
                  child: RectButton(
                      text: 'متابعون',
                      number: myfollowing.length,
                      onTap: () {
                        gotoFollowing();
                      },
                      iconData: Icons.groups,
                      buttonColor: AppColors.yellow),
                ),
                Expanded(
                  child: RectButton(
                      text: 'الأنشطة',
                      number: myActivities.length,
                      onTap: () {
                        gotoFriendsActivities();
                      },
                      iconData: Icons.comment,
                      buttonColor: AppColors.redProfileButton),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 20),
            SettingsButton(
                text: 'تعديل البيانات الشخصية',
                onTap: () {
                  Get.toNamed(AppRouteName.editPersonalData);
                },
                iconData: Icons.person),
            // SettingsButton(
            //     text: 'قائمة الاصدقاء',
            //     onTap: () {},
            //     iconData: Icons.people_alt_rounded),
            SettingsButton(
                text: 'المجموعات',
                onTap: () {
                  Get.toNamed(AppRouteName.gourps);
                },
                iconData: Icons.group),
            SettingsButton(
                text: 'جهات الإتصال',
                onTap: () {
                  Get.toNamed(AppRouteName.myContacts);
                },
                iconData: Icons.send),
            // SettingsButton(
            //     text: 'اللغة', onTap: () {}, iconData: Icons.language),
            SettingsButton(
                text: 'المحفظة',
                onTap: () {
                  Get.toNamed(AppRouteName.walletDetails);
                },
                iconData: Icons.wallet),
            SettingsButton(
                text: 'الحجوزات السابقة',
                onTap: () {
                  Get.toNamed(AppRouteName.resArchive);
                },
                iconData: Icons.task),
            SettingsButton(
                text: 'المناسبات السابقة',
                onTap: () {
                  Get.toNamed(AppRouteName.finishedOccasions);
                },
                iconData: Icons.event),
            SettingsButton(
                text: 'الفواتير',
                onTap: () {
                  Get.toNamed(AppRouteName.bills);
                },
                iconData: Icons.receipt),
            SettingsButton(
                text: 'تواصل معنا', onTap: () {}, iconData: Icons.receipt),
            SettingsButton(
              text: 'تسجيل الخروج',
              onTap: () {
                logout();
              },
              iconData: Icons.logout,
              cancelArrowForward: true,
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
