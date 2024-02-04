import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class GroupListItem extends StatelessWidget {
  const GroupListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('قروب الاستراحة', style: titleMedium),
                AutoSizeText(
                  'تاريخ الإنشاء: 3:00 15/12/2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.group,
                color: AppColors.textLight2,
                size: 20,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '5 اعضاء',
                style: titleSmall.copyWith(color: AppColors.textLight2),
              ),
            ],
          )
        ],
      ),
    );
  }
}
