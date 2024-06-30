import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomToggleButtonsOneOption extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final bool horizontalDirection;
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
      this.horizontalDirection = true,
      this.horizontalPadding = 0,
      this.verticalPadding = 0});

  @override
  State<CustomToggleButtonsOneOption> createState() =>
      _CustomToggleButtonsOneOptionState();
}

class _CustomToggleButtonsOneOptionState
    extends State<CustomToggleButtonsOneOption> {
  int selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      child: widget.horizontalDirection
          ? Row(
              children: [
                option(1, widget.firstOption, widget.onTapOne),
                const SizedBox(width: 10),
                option(2, widget.secondOption, widget.onTapTwo),
              ],
            )
          : Column(
              children: [
                option(1, widget.firstOption, widget.onTapOne),
                const SizedBox(width: 10),
                option(2, widget.secondOption, widget.onTapTwo),
              ],
            ),
    );
  }

  Row option(int optionNumber, String txt, void Function() function) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = optionNumber;
              function();
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
                    color: selectedOption == optionNumber
                        ? AppColors.secondaryColor
                        : null),
              ),
            ),
          ),
        ),
        Text(txt,
            style: titleSmall2.copyWith(
              color: AppColors.grayText,
            )),
      ],
    );
  }
}
