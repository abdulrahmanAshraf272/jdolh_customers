import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/transaction.dart';

class WalletOperationListItem extends StatefulWidget {
  final Transaction transaction;
  const WalletOperationListItem({
    super.key,
    required this.transaction,
  });

  @override
  State<WalletOperationListItem> createState() =>
      _WalletOperationListItemState();
}

class _WalletOperationListItemState extends State<WalletOperationListItem> {
  String transType = '';
  String flow = '';
  Color color = AppColors.green;
  String createtime = '';

  @override
  void initState() {
    if (widget.transaction.transType == 'deposit') {
      transType = 'شحن';
    } else if (widget.transaction.transType == 'withdrawal') {
      transType = 'خصم';
    } else if (widget.transaction.transType == 'R') {
      transType = 'حجز';
    } else if (widget.transaction.transType == 'RB') {
      transType = 'حجز و فاتورة';
    } else if (widget.transaction.transType == 'B') {
      transType = 'فاتورة';
    } else if (widget.transaction.transType == 'transferTo') {
      transType = 'تحويله الى صديق';
    } else if (widget.transaction.transType == 'transferFrom') {
      transType = 'تحويله من صديق';
    }

    if (widget.transaction.process == 'decrease') {
      color = AppColors.redButton;
      flow = '-';
    } else {
      color = AppColors.green;
      flow = '+';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(transType, style: titleMedium),
                AutoSizeText(
                  'بتاريخ: ${widget.transaction.createtime}',
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
                '$flow ${widget.transaction.amount} ${'ريال'.tr}',
                style: titleMedium.copyWith(
                  color: color,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
