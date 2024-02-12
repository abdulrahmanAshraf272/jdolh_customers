import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.green)),
            suffixIcon:
                InkWell(onTap: visiblePasswordOnTap, child: Icon(iconData))),
      ),
    );
  }
}

class CustomTextFormAuthTwo extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData iconData;
  final TextEditingController textEditingController;
  final String? Function(String?) valid;
  final bool? obscureText;
  final void Function()? visiblePasswordOnTap;
  const CustomTextFormAuthTwo(
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
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
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            suffixIcon:
                InkWell(onTap: visiblePasswordOnTap, child: Icon(iconData))),
      ),
    );
  }
}
