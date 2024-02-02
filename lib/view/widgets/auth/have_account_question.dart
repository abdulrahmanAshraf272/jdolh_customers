import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class HaveAccountQuestion extends StatelessWidget {
  final String text;
  final String buttonText;
  final Function() onPress;
  const HaveAccountQuestion(
      {super.key,
      required this.onPress,
      required this.text,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(color: AppColors.gray)),
        TextButton(
            onPressed: onPress,
            child: const Text("Sign In",
                style: TextStyle(color: AppColors.primaryColor)))
      ],
    );
  }
}
