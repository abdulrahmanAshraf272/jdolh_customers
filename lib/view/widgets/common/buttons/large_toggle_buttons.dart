import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              height: 44.h,
              color: selectedOption == 1 ? firstColor : AppColors.gray,
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
              height: 44.h,
              color: selectedOption == 2 ? secondColor : AppColors.gray,
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

class LargeToggleButtonsBrandProfile extends StatelessWidget {
  final String optionOne;
  final String optionTwo;
  final int optionSelected;
  final Function() onTapOne;
  final Function() onTapTwo;

  final bool twoColors;
  const LargeToggleButtonsBrandProfile(
      {super.key,
      required this.optionOne,
      required this.optionTwo,
      required this.onTapOne,
      required this.onTapTwo,
      required this.optionSelected,
      this.twoColors = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              onTapOne();
            },
            child: Container(
              height: 44.h,
              color: optionSelected == 0
                  ? AppColors.secondaryColor
                  : AppColors.gray,
              alignment: Alignment.center,
              child: Text(
                optionOne,
                style: titleMedium.copyWith(
                    color: optionSelected == 0
                        ? AppColors.white
                        : AppColors.textDark),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              onTapTwo();
            },
            child: Container(
              height: 44.h,
              color: optionSelected == 1
                  ? AppColors.secondaryColor
                  : AppColors.gray,
              alignment: Alignment.center,
              child: Text(
                optionTwo,
                style: titleMedium.copyWith(
                    color: optionSelected == 1
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
