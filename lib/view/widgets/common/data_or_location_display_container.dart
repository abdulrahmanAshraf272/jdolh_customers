import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class DateOrLocationDisplayContainer extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final bool iconEnd;
  final void Function()? onTap;
  final double horizontalMargin;
  final double verticalMargin;
  const DateOrLocationDisplayContainer({
    super.key,
    required this.hintText,
    this.iconData,
    this.onTap,
    this.iconEnd = true,
    this.horizontalMargin = 20,
    this.verticalMargin = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          //border: Border.all(color: Colors.black26),
          color: AppColors.gray,
        ),
        child: Row(
          children: [
            iconData != null && !iconEnd
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      iconData,
                      color: Colors.grey.shade700,
                    ),
                  )
                : const SizedBox(),
            Expanded(
                child: AutoSizeText(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.end,
              hintText,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: Colors.grey.shade500,
              ),
            )),
            iconData != null && iconEnd
                ? Icon(
                    iconData,
                    color: Colors.grey.shade500,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
