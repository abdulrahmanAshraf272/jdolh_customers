import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/home_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/occasion_display_location.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/activity.dart';
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
            appBar: customHomeAppBar(onTapSearch: () {
              Get.toNamed(AppRouteName.search);
            }, onTapNotification: () {
              Get.toNamed(AppRouteName.notifications);
            }),
            body: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: RefreshIndicator(
                onRefresh: () => controller.getHomseScreenData(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAds(),
                    CustomTitle(
                      title: 'مناسبات قريبة',
                      onTap: () {
                        controller.goToOccasionsScreen();
                      },
                      bottomPadding: 5,
                      topPadding: 10,
                    ),
                    controller.occasionsToDisplay.isEmpty
                        ? const Center(child: Text('لا توجد مناسبات قريبة'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.occasionsToDisplay.length > 3
                                ? 3
                                : controller.occasionsToDisplay.length,
                            itemBuilder: (context, index) =>
                                OccasionAcceptedListItem(
                                    from: controller.occasionsToDisplay[index]
                                        .occasionUsername!,
                                    title: controller.occasionsToDisplay[index]
                                        .occasionTitle!,
                                    date: controller.occasionsToDisplay[index]
                                        .occasionDatecreated!,
                                    location: controller
                                        .occasionsToDisplay[index]
                                        .occasionLocation!,
                                    creator: controller
                                        .occasionsToDisplay[index].creator!,
                                    onTapOpenLocation: () {
                                      onTapDisplayLocation(
                                          controller.occasionsToDisplay[index]);
                                    },
                                    onTapCard: () =>
                                        controller.goToOccasionsScreen())),
                    CustomTitle(
                      title: 'نشاطات الأصدقاء',
                      onTap: () {
                        controller.gotoFriendsActivities();
                      },
                      bottomPadding: 5,
                      topPadding: 20,
                    ),
                    controller.friendsActivities.isEmpty
                        ? const Center(child: Text('لا توجد نشاطات'))
                        : ListView.builder(
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
                                      controller
                                          .friendsActivities[index].isLiked = 0;
                                    } else {
                                      controller
                                          .friendsActivities[index].isLiked = 1;
                                    }
                                  },
                                )),
                    const CustomTitle(
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
                        child: controller.brands.isEmpty
                            ? const Center(child: Text('لا توجد نتائج'))
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                itemCount: controller.brands.length,
                                itemBuilder: (context, index) =>
                                    BrandExploreListItem(
                                        name:
                                            controller.brands[index]
                                                    .brandStoreName ??
                                                '',
                                        image:
                                            '${ApiLinks.logoImage}/${controller.brands[index].brandLogo}',
                                        onTap: () =>
                                            controller.gotoBrand(index)),
                              )),
                    CustomTitle(
                      title: 'الأكثر تسجيل وصول خلال ساعتين',
                      bottomPadding: 5,
                      onTap: () => controller.gotoExploreCheckin(),
                      customTextStyle: titleMedium,
                    ),
                    SizedBox(
                      height: 120.h,
                      child: controller.topCheckin.isEmpty
                          ? const Center(child: Text('لا توجد نتائج'))
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.topCheckin.length,
                              itemBuilder: (context, index) =>
                                  ExploreCheckinListItem(
                                      name: controller
                                              .topCheckin[index].placeName ??
                                          '')),
                    ),
                    CustomTitle(
                      title: 'الأكثر تقييم خلال اسبوع',
                      bottomPadding: 5,
                      onTap: () => controller.gotoShowAllTopRate(),
                      customTextStyle: titleMedium,
                    ),
                    SizedBox(
                      height: 125.h,
                      child: controller.topRate.isEmpty
                          ? const Center(child: Text('لا توجد نتائج'))
                          : ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.topRate.length,
                              itemBuilder: (context, index) =>
                                  PersonExploreListItem(
                                      name: controller
                                              .topRate[index].userName ??
                                          '',
                                      image:
                                          controller.topRate[index].userImage,
                                      onTap: () =>
                                          controller.gotoPersonProfile(index))),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
            )));
  }
}
