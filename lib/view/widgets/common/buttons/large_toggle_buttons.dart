import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class LargeToggleButtons extends StatefulWidget {
  final String optionOne;
  final String optionTwo;
  final int? displayNumber;
  final Function() onTapOne;
  final Function() onTapTwo;
  final bool twoColors;
  const LargeToggleButtons(
      {super.key,
      required this.optionOne,
      required this.optionTwo,
      required this.onTapOne,
      required this.onTapTwo,
      this.displayNumber,
      this.twoColors = false});

  @override
  State<LargeToggleButtons> createState() => _LargeToggleButtonsState();
}

class _LargeToggleButtonsState extends State<LargeToggleButtons> {
  int selectedOption = 1;
  Color firstColor = AppColors.secondaryColor;
  Color secondColor = AppColors.secondaryColor;

  @override
  Widget build(BuildContext context) {
    if (widget.twoColors == true) {
      secondColor = AppColors.redButton;
    }
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              widget.onTapOne();
              setState(() {
                selectedOption = 1;
              });
            },
            child: Container(
              height: 55,
              color: selectedOption == 1 ? firstColor : null,
              alignment: Alignment.center,
              child: Text(
                widget.displayNumber != null
                    ? '${widget.optionOne} (${widget.displayNumber})'
                    : widget.optionOne,
                style: titleMedium.copyWith(
                    color: selectedOption == 1
                        ? AppColors.white
                        : AppColors.textDark),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              widget.onTapTwo();
              setState(() {
                selectedOption = 2;
              });
            },
            child: Container(
              height: 55,
              color: selectedOption == 2 ? secondColor : null,
              alignment: Alignment.center,
              child: Text(
                widget.optionTwo,
                style: titleMedium.copyWith(
                    color: selectedOption == 2
                        ? AppColors.white
                        : AppColors.textDark),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
