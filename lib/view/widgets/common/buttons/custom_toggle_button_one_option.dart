import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomToggleButtonsOneOption extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final void Function() onTapOne;
  final void Function() onTapTwo;
  final double horizontalPadding;
  final double verticalPadding;
  const CustomToggleButtonsOneOption(
      {super.key,
      required this.firstOption,
      required this.secondOption,
      required this.onTapOne,
      required this.onTapTwo,
      this.horizontalPadding = 0,
      this.verticalPadding = 0});

  @override
  State<CustomToggleButtonsOneOption> createState() =>
      _CustomToggleButtonsOneOptionState();
}

class _CustomToggleButtonsOneOptionState
    extends State<CustomToggleButtonsOneOption> {
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = 1;
                    widget.onTapOne();
                    print(selectedOption);
                  });
                },
                child: Container(
                  height: 16,
                  width: 16,
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.5)),
                      shape: BoxShape.circle,
                      color: Color(0xffF3F3F3)),
                  child: Center(
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedOption == 1
                              ? AppColors.secondaryColor
                              : null),
                    ),
                  ),
                ),
              ),
              Text(widget.firstOption,
                  style: titleSmall2.copyWith(
                    color: AppColors.grayText,
                  )),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = 2;
                    widget.onTapTwo();
                    print(selectedOption);
                  });
                },
                child: Container(
                  height: 16,
                  width: 16,
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.5)),
                      shape: BoxShape.circle,
                      color: Color(0xffF3F3F3)),
                  child: Center(
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedOption == 2
                              ? AppColors.secondaryColor
                              : null),
                    ),
                  ),
                ),
              ),
              Text(widget.secondOption,
                  style: titleSmall2.copyWith(
                    color: AppColors.grayText,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
