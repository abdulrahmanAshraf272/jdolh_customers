import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/notifications_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/time_ago.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());
    return Scaffold(
      appBar: customAppBar(title: 'الإشعارات'.tr),
      body: GetBuilder<NotificationsController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            emptyText: 'لا توجد اشعارات'.tr,
            widget: ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) => NotificationListItem(
                title: controller.notifications[index].title ?? '',
                body: controller.notifications[index].body ?? '',
                image: controller.notifications[index].image ?? '',
                date: timeAgo(controller.notifications[index].datecreated!),
                onTap: () => controller.onTap(index),
              ),
            )),
      ),
    );
  }
}

class NotificationListItem extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String body;
  final String image;
  final String date;
  const NotificationListItem(
      {super.key,
      required this.title,
      required this.body,
      required this.image,
      required this.date,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.gray),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image != ''
                  ? FadeInImage.assetNetwork(
                      height: 42.w,
                      width: 42.w,
                      placeholder: 'assets/images/loading2.gif',
                      image: image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      height: 40.w,
                      width: 40.w,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(title,
                      maxLines: 1,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                      style: titleSmall),
                  AutoSizeText(body,
                      maxLines: 2,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                      style: titleSmall2),
                  AutoSizeText(date, style: titleSmall2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
