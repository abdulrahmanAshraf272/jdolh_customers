import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class BillListItem extends StatelessWidget {
  final Bill bill;
  final void Function() onTap;
  const BillListItem({super.key, required this.bill, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText('${'فاتورة رقم'.tr} ${bill.billId}',
                      maxLines: 1,
                      minFontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      style: titleMedium),
                  AutoSizeText(
                    '${bill.brandName}, ${bill.bchName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: titleSmall2.copyWith(color: AppColors.grayText),
                  ),
                  AutoSizeText(
                    '${'بتاريخ'.tr}: ${bill.billCreatetime}',
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
                  '${bill.billAmount} ${'ريال'.tr}',
                  style: titleMedium.copyWith(
                      color: bill.billIsPayed == 0
                          ? AppColors.redText
                          : AppColors.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
                if (bill.billIsPayed == 0) const SizedBox(height: 10),
                if (bill.billIsPayed == 0)
                  CustomButton(
                    onTap: onTap,
                    text: 'دفع'.tr,
                    size: 1.1,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
