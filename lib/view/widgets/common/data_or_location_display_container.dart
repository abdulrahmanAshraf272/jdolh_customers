import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class DateOrLocationDisplayContainer extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final void Function() onTap;
  const DateOrLocationDisplayContainer({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            Expanded(
                child: Text(
              hintText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: Colors.grey.shade500,
              ),
            )),
            Icon(
              iconData,
              color: Colors.grey.shade500,
            )
          ],
        ),
      ),
    );
  }
}
