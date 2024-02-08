import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/guaranteed_icon.dart';

class BrandImageNameFollowers extends StatelessWidget {
  const BrandImageNameFollowers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/avatar_person.jpg',
            height: 47.w,
            width: 47.w,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText('مطعم البيك',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMediumWhite),
                SizedBox(
                  width: 5,
                ),
                GuaranteedIcon(active: true)
              ],
            ),
            Spacer(),
            Text('849-متابعين', style: titleSmall3Gray)
          ],
        ),
      ],
    );
  }
}
