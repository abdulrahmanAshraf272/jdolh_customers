import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArrowBackButton extends StatelessWidget {
  final Color color;
  final double horizontalMargin;
  const ArrowBackButton(
      {super.key, this.color = Colors.white, this.horizontalMargin = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: color.withOpacity(0.2)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.arrow_back_ios,
              color: color,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
