import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final IconData iconData;
  final bool cancelArrowForward;
  const SettingsButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.iconData,
      this.cancelArrowForward = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 45.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      iconData,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Expanded(
                      child: AutoSizeText(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                    ),
                  )),
                  !cancelArrowForward
                      ? Icon(
                          Icons.arrow_forward,
                          color: Colors.grey.shade500,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
