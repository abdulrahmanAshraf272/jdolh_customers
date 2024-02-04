import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/localization/words/home.dart';
import 'package:jdolh_customers/test_screen2.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_explore.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/person_explore.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/home/custom_ads.dart';
import 'package:jdolh_customers/view/widgets/home/custom_home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(onTapSearch: () {}, onTapNotification: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAds(),
            CustomTitle(
              title: 'مواعيد قريبة',
              onTap: () {
                Get.to(TestScreen2());
              },
              bottomPadding: 5,
              topPadding: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => AppointmentListItem()),
            CustomTitle(
              title: 'نشاطات الأصدقاء',
              onTap: () {},
              bottomPadding: 5,
              topPadding: 20,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => ActivityListItem()),
            CustomTitle(
              title: 'أكتشف',
              bottomPadding: 5,
              topPadding: 20,
            ),
            CustomTitle(
              title: 'أكثر الأماكن زيارة خلال اسبوع',
              bottomPadding: 5,
              onTap: () {},
              customTextStyle: titleMedium,
            ),
            SizedBox(
              height: 90.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: 6,
                  itemBuilder: (context, index) => BrandExploreListItem()),
            ),
            CustomTitle(
              title: 'أكثر الأماكن تسجيل وصول خلال ساعتين',
              bottomPadding: 5,
              onTap: () {},
              customTextStyle: titleMedium,
            ),
            SizedBox(
              height: 90.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) => BrandExploreListItem()),
            ),
            CustomTitle(
              title: 'اكثر المستخدمين تقييم خلال اسبوع',
              bottomPadding: 5,
              onTap: () {},
              customTextStyle: titleMedium,
            ),
            SizedBox(
              height: 115.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) => PersonExploreListItem()),
            ),
          ],
        ),
      ),
    );
  }
}
