import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final IconData? iconData;
  final double size;
  final Color buttonColor;
  final Color textColor;
  final double? height;
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.iconData,
      this.size = 1,
      this.height,
      this.buttonColor = AppColors.secondaryColor,
      this.textColor = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: height,
        //padding: EdgeInsets.symmetric(vertical: 6 * size, horizontal: 12 * size),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10 * size),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10 * size),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: (12 * size),
                          color: textColor,
                        ),
                      ),
                      iconData != null
                          ? SizedBox(
                              width: 5 * size,
                            )
                          : SizedBox(),
                      iconData != null
                          ? Icon(
                              iconData,
                              size: 16 * size,
                              color: AppColors.textDark,
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
