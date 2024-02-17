import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/main_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/test_screen2.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/appointment.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_explore.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/occasion.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/person_explore.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/home/custom_ads.dart';
import 'package:jdolh_customers/view/widgets/home/custom_home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetBuilder<MainController>(
        builder: (controller) => Scaffold(
              appBar: customHomeAppBar(
                  onTapSearch: () {
                    Get.toNamed(AppRouteName.search);
                  },
                  onTapNotification: () {}),
              body: HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomAds(),
                        CustomTitle(
                          title: 'مناسبات قريبة',
                          onTap: () {
                            controller.goToOccasionsScreen();
                          },
                          bottomPadding: 5,
                          topPadding: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.acceptedOccasions.length,
                            itemBuilder: (context, index) =>
                                OccasionAcceptedListItem(
                                  from: controller.acceptedOccasions[index]
                                      .occasionUsername!,
                                  title: controller
                                      .acceptedOccasions[index].occasionTitle!,
                                  date: controller.acceptedOccasions[index]
                                      .occasionDatecreated!,
                                  location: controller.acceptedOccasions[index]
                                      .occasionLocation!,
                                  creator: controller
                                      .acceptedOccasions[index].creator!,
                                  onTapOpenLocation: () {},
                                  onTapCard: () =>
                                      controller.onTapOccasionCard(index),
                                )),
                        CustomTitle(
                          title: 'نشاطات الأصدقاء',
                          onTap: () {
                            Get.toNamed(AppRouteName.friendsActivities);
                          },
                          bottomPadding: 5,
                          topPadding: 20,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) =>
                                ActivityListItem()),
                        CustomTitle(
                          title: 'أكتشف',
                          bottomPadding: 5,
                          topPadding: 20,
                        ),
                        CustomTitle(
                          title: 'أكثر الأماكن زيارة خلال اسبوع',
                          bottomPadding: 5,
                          onTap: () {
                            Get.toNamed(AppRouteName.exploreBrand);
                          },
                          customTextStyle: titleMedium,
                        ),
                        SizedBox(
                          height: 90.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: 6,
                              itemBuilder: (context, index) =>
                                  BrandExploreListItem()),
                        ),
                        CustomTitle(
                          title: 'أكثر الأماكن تسجيل وصول خلال ساعتين',
                          bottomPadding: 5,
                          onTap: () {
                            Get.toNamed(AppRouteName.exploreBrand);
                          },
                          customTextStyle: titleMedium,
                        ),
                        SizedBox(
                          height: 90.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              physics: BouncingScrollPhysics(),
                              itemCount: 6,
                              itemBuilder: (context, index) =>
                                  BrandExploreListItem()),
                        ),
                        CustomTitle(
                          title: 'اكثر المستخدمين تقييم خلال اسبوع',
                          bottomPadding: 5,
                          onTap: () {
                            Get.toNamed(AppRouteName.explorePeople);
                          },
                          customTextStyle: titleMedium,
                        ),
                        SizedBox(
                          height: 115.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: 6,
                              itemBuilder: (context, index) =>
                                  PersonExploreListItem()),
                        ),
                      ],
                    ),
                  )),
            ));
  }
}
