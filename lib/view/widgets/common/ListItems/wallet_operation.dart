import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class WalletOperationListItem extends StatelessWidget {
  const WalletOperationListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('شحن', style: titleMedium),
                AutoSizeText(
                  'بتاريخ: 3:00 15/12/2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '34 ريال',
                style: titleMedium.copyWith(
                  color: AppColors.secondaryColor,
                  //fontWeight: FontWeight.b6
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
