import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class BrandExploreListItem extends StatelessWidget {
  final String? image;
  final String name;
  final void Function() onTap;
  const BrandExploreListItem(
      {super.key,
      required this.image,
      required this.name,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65.w,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image != null
                  ? FadeInImage.assetNetwork(
                      width: 65.w,
                      height: 65.w,
                      placeholder: 'assets/images/loading2.gif',
                      image: image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/noImageAvailable.jpg',
                      fit: BoxFit.cover,
                      width: 65.w,
                      height: 65.w,
                    ),
            ),
            SizedBox(height: 8),
            AutoSizeText(
              name,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: AppColors.textDark,
              ),
            )
          ],
        ),
      ),
    );
  }
}
