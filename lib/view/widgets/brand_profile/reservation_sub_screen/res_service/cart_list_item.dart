import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CartListItem extends StatelessWidget {
  final String? image;
  final String name;
  final String desc;
  final String price;
  final int duration;
  final void Function() onTapDelete;
  const CartListItem(
      {super.key,
      required this.image,
      required this.name,
      required this.desc,
      required this.price,
      required this.duration,
      required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading2.gif',
                    image: '${ApiLinks.itemsImage}/$image',
                    width: 100.w,
                    height: 75,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/noImageAvailable.jpg',
                    height: 75,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                AutoSizeText(
                  name,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.textDark,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      color: AppColors.textDark.withOpacity(0.7),
                    ),
                  ),
                ),
                Text(
                  '$duration ${'دقيقة'.tr}',
                  style: titleSmall2,
                )
              ],
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            flex: 1,
            child: Text(
              '$price ${'ريال'.tr}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(width: 5),
          TextButton(
              onPressed: onTapDelete,
              child: Text(
                'إزالة'.tr,
                style:
                    const TextStyle(color: AppColors.redButton, fontSize: 12),
              )),
        ],
      ),
    );
  }
}
