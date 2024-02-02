import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData iconData;
  final TextEditingController textEditingController;
  final String? Function(String?) valid;
  final bool? obscureText;
  final void Function()? visiblePasswordOnTap;
  const CustomTextFormAuth(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.iconData,
      required this.textEditingController,
      required this.valid,
      this.obscureText,
      this.visiblePasswordOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText == null || obscureText == false ? false : true,
        keyboardType: labelText == 'Email'
            ? TextInputType.emailAddress
            : labelText == 'Phone'
                ? TextInputType.number
                : TextInputType.name,
        validator: valid,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(labelText)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon:
                InkWell(onTap: visiblePasswordOnTap, child: Icon(iconData))),
      ),
    );
  }
}
