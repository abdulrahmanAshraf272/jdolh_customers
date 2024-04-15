import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/more_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/widgets/more_screen/rect_button.dart';
import 'package:jdolh_customers/view/widgets/more_screen/settings_button.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MoreController());
    return Scaffold(
        //appBar: customAppBar(title: 'الفواتير'),
        body: GetBuilder<MoreController>(
      builder: (controller) => SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: SizedBox()),
            CircleAvatar(
              radius: Get.width / 6, // Adjust as needed
              backgroundImage: controller.image != ''
                  ? NetworkImage(
                      '${ApiLinks.customerImage}/${controller.image}')
                  : const AssetImage('assets/images/person4.jpg')
                      as ImageProvider,
            ),
            const SizedBox(height: 10),
            Text(
              controller.name,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              controller.username,
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
                      number: controller.myfollowers.length,
                      onTap: () {
                        controller.gotoFollowers();
                      },
                      iconData: Icons.group,
                      buttonColor: AppColors.green),
                ),
                Expanded(
                  child: RectButton(
                      text: 'متابعون',
                      number: controller.myfollowing.length,
                      onTap: () {
                        controller.gotoFollowing();
                      },
                      iconData: Icons.groups,
                      buttonColor: AppColors.yellow),
                ),
                Expanded(
                  child: RectButton(
                      text: 'الأنشطة',
                      number: controller.myActivities.length,
                      onTap: () {
                        controller.gotoFriendsActivities();
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
            SettingsButton(
                text: 'قائمة الاصدقاء',
                onTap: () {},
                iconData: Icons.people_alt_rounded),
            SettingsButton(
                text: 'المجموعات',
                onTap: () {
                  Get.toNamed(AppRouteName.gourps);
                },
                iconData: Icons.group),
            SettingsButton(
                text: 'ارسال دعوة',
                onTap: () {
                  Get.toNamed(AppRouteName.myContacts);
                },
                iconData: Icons.send),
            SettingsButton(
                text: 'اللغة', onTap: () {}, iconData: Icons.language),
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
                controller.logout();
              },
              iconData: Icons.logout,
              cancelArrowForward: true,
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    ));
  }
}
