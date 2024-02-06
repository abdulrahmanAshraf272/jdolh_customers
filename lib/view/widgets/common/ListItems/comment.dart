import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/rating.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: AppColors.secondaryLightCardAppointment,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('تجربة ممتازة واجواء رائعة',
                    maxLines: 2,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleSmall),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.handshake_outlined,
                      color: AppColors.secondaryColor,
                    ),
                    Text(
                      '23',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.secondaryColor),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 5),
          Rating(rating: 4.5),
          const SizedBox(width: 12),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/avatar_person.jpg',
                  height: 37.h,
                  width: 37.h,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                onTap: () {},
                text: 'الصفحة',
                size: 0.9,
              )
            ],
          ),
        ],
      ),
    );
  }
}
