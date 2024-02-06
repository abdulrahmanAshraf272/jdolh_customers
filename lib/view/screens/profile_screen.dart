import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/comment.dart';
import 'package:jdolh_customers/view/widgets/more_screen/rect_button.dart';

class TestScreen2 extends StatelessWidget {
  const TestScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: customAppBar(title: 'الفواتير'),
      body: SafeArea(
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
      ),
    );
  }
}
