import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/home_controller.dart';
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
import 'package:jdolh_customers/view/widgets/explore_checkin_list_item.dart';
import 'package:jdolh_customers/view/widgets/home/custom_ads.dart';
import 'package:jdolh_customers/view/widgets/home/custom_home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
            appBar: customHomeAppBar(
                onTapSearch: () {
                  Get.toNamed(AppRouteName.search);
                },
                onTapNotification: () {}),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAds(),
                  // CustomTitle(
                  //   title: 'مناسبات قريبة',
                  //   onTap: () {
                  //     controller.goToOccasionsScreen();
                  //   },
                  //   bottomPadding: 5,
                  //   topPadding: 10,
                  // ),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: controller.acceptedOccasions.length,
                  //     itemBuilder: (context, index) =>
                  //         OccasionAcceptedListItem(
                  //           from: controller.acceptedOccasions[index]
                  //               .occasionUsername!,
                  //           title: controller
                  //               .acceptedOccasions[index].occasionTitle!,
                  //           date: controller.acceptedOccasions[index]
                  //               .occasionDatecreated!,
                  //           location: controller.acceptedOccasions[index]
                  //               .occasionLocation!,
                  //           creator: controller
                  //               .acceptedOccasions[index].creator!,
                  //           onTapOpenLocation: () {},
                  //           onTapCard: () =>
                  //               controller.onTapOccasionCard(index),
                  //         )),
                  CustomTitle(
                    title: 'نشاطات الأصدقاء',
                    onTap: () {
                      controller.gotoFriendsActivities();
                    },
                    bottomPadding: 5,
                    topPadding: 20,
                  ),
                  HandlingDataView(
                    statusRequest: controller.statusFriendsActivity,
                    widget: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.friendsActivities.length > 3
                            ? 3
                            : controller.friendsActivities.length,
                        itemBuilder: (context, index) => ActivityListItem(
                              activity: controller.friendsActivities[index],
                              onTapLike: () {
                                if (controller
                                        .friendsActivities[index].isLiked ==
                                    1) {
                                  controller.friendsActivities[index].isLiked =
                                      0;
                                } else {
                                  controller.friendsActivities[index].isLiked =
                                      1;
                                }
                              },
                            )),
                  ),
                  CustomTitle(
                    title: 'أكتشف',
                    bottomPadding: 5,
                    topPadding: 20,
                  ),
                  CustomTitle(
                    title: 'الأكثر زيارة خلال اسبوع',
                    bottomPadding: 5,
                    onTap: () {
                      controller.gotoExploreBrand();
                    },
                    customTextStyle: titleMedium,
                  ),
                  SizedBox(
                      height: 120.h,
                      child: HandlingDataView(
                          statusRequest: controller.statusTopRes,
                          widget: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: controller.brands.length,
                            itemBuilder: (context, index) => BrandExploreListItem(
                                name: controller.brands[index].brandStoreName ??
                                    '',
                                image:
                                    '${ApiLinks.logoImage}/${controller.brands[index].brandLogo}',
                                onTap: () => controller.gotoBrand(index)),
                          ))),
                  CustomTitle(
                    title: 'الأكثر تسجيل وصول خلال ساعتين',
                    bottomPadding: 5,
                    onTap: () => controller.gotoExploreCheckin(),
                    customTextStyle: titleMedium,
                  ),
                  SizedBox(
                    height: 120.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.topCheckin.length,
                        itemBuilder: (context, index) => ExploreCheckinListItem(
                            name:
                                controller.topCheckin[index].placeName ?? '')),
                  ),
                  CustomTitle(
                    title: 'الأكثر تقييم خلال اسبوع',
                    bottomPadding: 5,
                    onTap: () => controller.gotoShowAllTopRate(),
                    customTextStyle: titleMedium,
                  ),
                  SizedBox(
                    height: 125.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.topRate.length,
                        itemBuilder: (context, index) => PersonExploreListItem(
                            name: controller.topRate[index].userName ?? '',
                            image: controller.topRate[index].userImage,
                            onTap: () => controller.gotoPersonProfile(index))),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            )));
  }
}
