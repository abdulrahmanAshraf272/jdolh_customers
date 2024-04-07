import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/more_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/more_screen/rect_button.dart';
import 'package:jdolh_customers/view/widgets/more_screen/settings_button.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoreController());
    return Scaffold(
      //appBar: customAppBar(title: 'الفواتير'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                'عبدالرحمن التميمي',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                '@abdulrahman23',
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
                        number: 120,
                        onTap: () {},
                        iconData: Icons.group,
                        buttonColor: AppColors.green),
                  ),
                  Expanded(
                    child: RectButton(
                        text: 'متابعون',
                        number: 120,
                        onTap: () {},
                        iconData: Icons.groups,
                        buttonColor: AppColors.yellow),
                  ),
                  Expanded(
                    child: RectButton(
                        text: 'الأنشطة',
                        number: 120,
                        onTap: () {},
                        iconData: Icons.comment,
                        buttonColor: AppColors.redProfileButton),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
