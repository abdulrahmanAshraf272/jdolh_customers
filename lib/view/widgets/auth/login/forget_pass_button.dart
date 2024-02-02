import 'package:flutter/material.dart';

class ForgetPassButton extends StatelessWidget {
  final Function() onPress;
  const ForgetPassButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
          onPressed: onPress,
          child: Text(
            'Forget Password?',
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                decoration: TextDecoration.underline),
            textAlign: TextAlign.end,
          )),
    );
  }
}
