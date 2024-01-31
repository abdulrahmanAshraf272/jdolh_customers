import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class CustomButtonLang extends StatelessWidget {
  final String textButton;
  final void Function() onPressed;
  const CustomButtonLang(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        width: double.infinity,
        child: MaterialButton(
          color: AppColors.primaryColor,
          textColor: Colors.white,
          onPressed: onPressed,
          child: Text(textButton,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ));
  }
}
