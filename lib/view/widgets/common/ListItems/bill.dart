import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class BillListItem extends StatelessWidget {
  final bool paid;
  final Function()? pay;
  const BillListItem({super.key, required this.paid, this.pay});

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
                AutoSizeText('فاتورة رقم 47327',
                    maxLines: 1,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: titleMedium),
                AutoSizeText(
                  'مطعم البيك, فرع المنز',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmall2.copyWith(color: AppColors.grayText),
                ),
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
                    color: !paid ? AppColors.redText : AppColors.secondaryColor,
                    fontWeight: FontWeight.bold),
              ),
              !paid
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(),
              !paid
                  ? CustomButton(
                      onTap: () {},
                      text: 'دفع',
                      size: 1.1,
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
