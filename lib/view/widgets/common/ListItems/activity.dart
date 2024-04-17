import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/view/widgets/activity_bottom_sheet.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/sounds.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/activity.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class ActivityListItem extends StatefulWidget {
  final Activity activity;
  final void Function() onTapLike;
  final int cardStatus;
  const ActivityListItem({
    super.key,
    required this.activity,
    required this.onTapLike,
    this.cardStatus = 0,
  });

  @override
  State<ActivityListItem> createState() => _ActivityListItemState();
}

class _ActivityListItemState extends State<ActivityListItem> {
  late int isLiked;
  @override
  void initState() {
    isLiked = widget.activity.isLiked ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
            ActivityBottomSheet(
              activity: widget.activity,
              onTapGotoPage: () {
                Get.toNamed(AppRouteName.brandProfile, arguments: {
                  "fromActivity": true,
                  "bchid": widget.activity.bchid
                });
              },
            ),
            backgroundColor: Colors.black.withOpacity(0.4));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.activityCard,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.cardStatus == 0)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.activity.userImage != '' &&
                        widget.activity.userImage != null
                    ? FadeInImage.assetNetwork(
                        height: 40.w,
                        width: 40.w,
                        placeholder: 'assets/images/loading2.gif',
                        image:
                            '${ApiLinks.customerImage}/${widget.activity.userImage}',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/person4.jpg',
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
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: AppColors.textDark.withOpacity(0.7),
                          ),
                          children: [
                        widget.cardStatus == 2
                            ? const TextSpan(text: 'قمت ')
                            : const TextSpan(text: 'قام '),
                        if (widget.cardStatus == 0)
                          TextSpan(
                              text: '${widget.activity.username} ',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: AppColors.textDark,
                              )),
                        TextSpan(
                          text: widget.activity.type == 'rate'
                              ? 'بتقييم '
                              : widget.activity.type == 'checkin'
                                  ? 'بتسجيل وصول '
                                  : 'بتسجيل وصول ',
                        ),
                        TextSpan(
                            text: widget.activity.placeName,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: AppColors.primaryColor,
                            ))
                      ])),
                  AutoSizeText(
                    widget.activity.timedate ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: titleSmallGray,
                  ),
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: () {
                      ActivityLike activityLike = ActivityLike();
                      widget.onTapLike();
                      if (isLiked == 1) {
                        activityLike.likeUnlikeActivity(
                            widget.activity.type!, widget.activity.id!, 0);
                        isLiked = 0;
                        widget.activity.likesNo = widget.activity.likesNo! - 1;
                      } else {
                        activityLike.likeUnlikeActivity(
                            widget.activity.type!, widget.activity.id!, 1);
                        //Sounds.like();
                        isLiked = 1;
                        widget.activity.likesNo = widget.activity.likesNo! + 1;
                      }
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 18,
                          color: isLiked == 1
                              ? AppColors.secondaryColor
                              : Colors.grey,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${widget.activity.likesNo}',
                          style: const TextStyle(
                              color: AppColors.secondaryColor, fontSize: 14),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            widget.activity.type == 'rate'
                ? Rating(rating: widget.activity.rate ?? 5)
                : const Icon(
                    Icons.pin_drop,
                    color: Colors.grey,
                  )
            //Icon(Icons.pin_drop_outlined)
          ],
        ),
      ),
    );
  }
}

class ActivityLike {
  StatusRequest likeStatusRequiest = StatusRequest.none;
  ActivityData activityData = ActivityData(Get.find());
  MyServices myServices = Get.find();
  onTapLike(Activity activity) {
    if (activity.isLiked == 1) {
      likeUnlikeActivity(activity.type!, activity.id!, 0);
      activity.isLiked = 0;
    } else {
      likeUnlikeActivity(activity.type!, activity.id!, 1);
      activity.isLiked = 1;
    }
  }

  likeUnlikeActivity(String activityType, int activityId, int like) async {
    var response = await activityData.likeUnlikeActivity(
        userid: myServices.getUserid(),
        activityType: activityType,
        activityId: activityId.toString(),
        like: like.toString());
    likeStatusRequiest = handlingData(response);
    if (likeStatusRequiest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('like/unlike success');
      } else {
        print('like/unlike failure');
      }
    }
  }
}
