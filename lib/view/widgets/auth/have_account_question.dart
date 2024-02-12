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
        Text(text, style: TextStyle(color: Colors.grey)),
        TextButton(
            onPressed: onPress,
            child: Text(buttonText,
                style: TextStyle(color: AppColors.primaryColor)))
      ],
    );
  }
}
