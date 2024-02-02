import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class CustomButtonOne extends StatelessWidget {
  final String textButton;
  final void Function() onPressed;
  const CustomButtonOne(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width - 40,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: MaterialButton(
            color: AppColors.primaryColor,
            textColor: Colors.white,
            onPressed: onPressed,
            child: Text(textButton,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
