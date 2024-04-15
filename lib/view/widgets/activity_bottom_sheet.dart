import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/activity.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class ActivityBottomSheet extends StatelessWidget {
  final Activity activity;
  final void Function() onTapGotoPage;
  const ActivityBottomSheet(
      {super.key, required this.activity, required this.onTapGotoPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: activity.userImage != '' && activity.userImage != null
                    ? FadeInImage.assetNetwork(
                        height: 40.w,
                        width: 40.w,
                        placeholder: 'assets/images/loading2.gif',
                        image:
                            '${ApiLinks.customerImage}/${activity.userImage}',
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
                          const TextSpan(text: 'قام '),
                          TextSpan(
                              text: activity.username,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: AppColors.textDark,
                              )),
                          TextSpan(
                            text: activity.type == 'rate'
                                ? ' بتقييم '
                                : activity.type == 'checkin'
                                    ? ' بتسجيل وصول '
                                    : ' بتسجيل وصول ',
                          ),
                          TextSpan(
                              text: activity.placeName,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: AppColors.primaryColor,
                              ))
                        ])),
                    AutoSizeText(
                      activity.timedate ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleSmallGray,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(endIndent: 20, indent: 20),
          if (activity.type == 'rate')
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: activity.brandlogo != '' && activity.brandlogo != null
                      ? FadeInImage.assetNetwork(
                          height: 40.w,
                          width: 40.w,
                          placeholder: 'assets/images/loading2.gif',
                          image: '${ApiLinks.logoImage}/${activity.brandlogo}',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/person4.jpg',
                          fit: BoxFit.cover,
                          height: 40.w,
                          width: 40.w,
                        ),
                ),
                const SizedBox(width: 10),
                Rating(rating: activity.rate ?? 5),
                const Spacer(),
                CustomButton(onTap: onTapGotoPage, text: 'الصفحة')
              ],
            ),
          const SizedBox(height: 20),
          Text('${activity.comment}'),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
