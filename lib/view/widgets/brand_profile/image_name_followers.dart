import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';

class BrandImageNameFollowers extends StatelessWidget {
  final String? logoImage;
  final String brandName;
  final String bchName;
  final int followrsNo;
  final int isVerified;
  final void Function() onTapBchFollowers;
  const BrandImageNameFollowers({
    super.key,
    required this.logoImage,
    required this.brandName,
    required this.bchName,
    required this.followrsNo,
    required this.isVerified,
    required this.onTapBchFollowers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: logoImage != null
              ? FadeInImage.assetNetwork(
                  width: 50.w,
                  height: 50.w,
                  placeholder: 'assets/images/loading2.gif',
                  image: logoImage!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/noImageAvailable.jpg',
                  fit: BoxFit.cover,
                  width: 50.w,
                  height: 50.w,
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: AutoSizeText(brandName,
                        maxLines: 1,
                        minFontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.white,
                        )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GuaranteedIcon(active: isVerified == 1 ? true : false)
                ],
              ),
              AutoSizeText(bchName,
                  maxLines: 1,
                  minFontSize: 7,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.white,
                  )),
              // Spacer(),
              GestureDetector(
                  onTap: onTapBchFollowers,
                  child: Text('$followrsNo-متابعين', style: titleSmall3Gray))
            ],
          ),
        ),
      ],
    );
  }
}
