import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('مناسبة من عبدالرحمن العنزي',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMedium),
                AutoSizeText(
                  'دعوة عشاء 3:00 15/12/2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmall2.copyWith(color: AppColors.grayText),
                ),
                AutoSizeText(
                  'الرياض, شارع الحسن بن الحسين',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmallGray,
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomButton(
                onTap: () {},
                text: 'قبول',
                size: 1.15,
                buttonColor: AppColors.secondaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () {},
                text: 'اعتذار',
                size: 1.15,
                buttonColor: AppColors.redButton,
              )
            ],
          )
        ],
      ),
    );
  }
}
