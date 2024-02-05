import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class GuaranteedIcon extends StatelessWidget {
  final bool active;
  const GuaranteedIcon({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return active
        ? Container(
            height: 15,
            width: 15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.secondaryColor),
            child: Text(
              'j',
              style: TextStyle(color: AppColors.white, fontSize: 9),
            ),
          )
        : SizedBox(
            height: 15,
            width: 15,
          );
  }
}
