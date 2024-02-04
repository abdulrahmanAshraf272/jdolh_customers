import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({
    super.key,
  });

  @override
  State<CustomToggleButtons> createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedOption == 1) {
                    selectedOption = 0;
                  } else {
                    selectedOption = 1;
                  }
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
            Text('تقسيم رسوم الحجز',
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
                  if (selectedOption == 2) {
                    selectedOption = 0;
                  } else {
                    selectedOption = 2;
                  }
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
            Text('معزوم',
                style: titleSmall2.copyWith(
                  color: AppColors.grayText,
                )),
          ],
        ),
      ],
    );
  }
}
