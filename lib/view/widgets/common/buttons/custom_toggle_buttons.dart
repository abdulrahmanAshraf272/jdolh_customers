import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomResInvitorsToggleButtons extends StatelessWidget {
  final int type;
  final void Function() onTapPayFromHimself;
  final void Function() onTapDivide;
  final void Function() onTapWithoutPay;
  const CustomResInvitorsToggleButtons({
    super.key,
    required this.type,
    required this.onTapDivide,
    required this.onTapWithoutPay,
    required this.onTapPayFromHimself,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onTapPayFromHimself,
              child: Container(
                height: 16,
                width: 16,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                    shape: BoxShape.circle,
                    color: const Color(0xffF3F3F3)),
                child: Center(
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: type == 0 ? AppColors.secondaryColor : null),
                  ),
                ),
              ),
            ),
            Text('يدفع رسومه فقط',
                style: titleSmall2.copyWith(
                  color: AppColors.grayText,
                )),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onTapDivide,
              child: Container(
                height: 16,
                width: 16,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                    shape: BoxShape.circle,
                    color: const Color(0xffF3F3F3)),
                child: Center(
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: type == 1 ? AppColors.secondaryColor : null),
                  ),
                ),
              ),
            ),
            Text('تقسيم رسوم الحجز',
                style: titleSmall2.copyWith(
                  color: AppColors.grayText,
                )),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            GestureDetector(
              onTap: onTapWithoutPay,
              child: Container(
                height: 16,
                width: 16,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                    shape: BoxShape.circle,
                    color: const Color(0xffF3F3F3)),
                child: Center(
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: type == 2 ? AppColors.secondaryColor : null),
                  ),
                ),
              ),
            ),
            Text('معزوم',
                style: titleSmall2.copyWith(
                  color: AppColors.grayText,
                )),
          ],
        ),
      ],
    );
  }
}
