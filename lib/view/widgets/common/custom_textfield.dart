import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

///Common used TextField -be careful when modify the original code-
class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData? iconData;
  final Function(String)? onChange;
  const CustomTextField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.iconData,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: onChange,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 14),
                // contentPadding: const EdgeInsets.symmetric(
                //     vertical: 5, horizontal: 30),
                border: InputBorder.none,
              ),
            ),
          ),
          iconData != null
              ? Icon(
                  iconData,
                  size: 30,
                  color: Colors.grey,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
