import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class ConfirmRefuseButtons extends StatelessWidget {
  final void Function() onTapConfirm;
  final void Function() onTapRefuse;
  const ConfirmRefuseButtons({
    super.key,
    required this.onTapConfirm,
    required this.onTapRefuse,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: MaterialButton(
              onPressed: onTapConfirm,
              color: AppColors.secondaryColor,
              child: Container(
                height: 44.h,
                alignment: Alignment.center,
                child: Text(
                  'تأكيد حضور',
                  style: titleMedium.copyWith(color: AppColors.white),
                ),
              ),
            )),
        Expanded(
          flex: 1,
          child: MaterialButton(
            onPressed: onTapRefuse,
            color: AppColors.redButton,
            child: Container(
              height: 44.h,
              alignment: Alignment.center,
              child: Text(
                'رفض',
                style: titleMedium.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
