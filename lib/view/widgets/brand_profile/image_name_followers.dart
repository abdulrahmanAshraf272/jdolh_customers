import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';

class BrandImageNameFollowers extends StatelessWidget {
  final String? logoImage;
  final String brandName;
  final int followrsNo;
  final int isVerified;
  const BrandImageNameFollowers({
    super.key,
    required this.logoImage,
    required this.brandName,
    required this.followrsNo,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: logoImage != null
              ? FadeInImage.assetNetwork(
                  width: 47.w,
                  height: 47.w,
                  placeholder: 'assets/images/loading2.gif',
                  image: logoImage!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/noImageAvailable.jpg',
                  fit: BoxFit.cover,
                  width: 47.w,
                  height: 47.w,
                ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText(brandName,
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMediumWhite),
                SizedBox(
                  width: 5,
                ),
                GuaranteedIcon(active: isVerified == 1 ? true : false)
              ],
            ),
            Spacer(),
            Text('$followrsNo-متابعين', style: titleSmall3Gray)
          ],
        ),
      ],
    );
  }
}
