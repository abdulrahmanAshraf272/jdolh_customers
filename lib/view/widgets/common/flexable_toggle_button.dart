import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class FlixableToggleButton extends StatefulWidget {
  final List<String> list;
  final double cirleSize;
  final double fontSize;
  const FlixableToggleButton(
      {super.key, required this.list, this.cirleSize = 16, this.fontSize = 11});

  @override
  State<FlixableToggleButton> createState() => _FlixableToggleButtonState();
}

class _FlixableToggleButtonState extends State<FlixableToggleButton> {
  int selectedIndex = 0;
  //List<String> list = ['كبير', 'متوسط', 'صغير'];
  @override
  Widget build(BuildContext context) {
    print('=========ssss======');
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.list.length,
        itemBuilder: (context, index) => toggleButtonItem(index));
  }

  Widget toggleButtonItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Row(
        children: [
          Container(
            height: widget.cirleSize,
            width: widget.cirleSize,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                shape: BoxShape.circle,
                color: const Color(0xffF3F3F3)),
            child: Center(
              child: Container(
                height: widget.cirleSize,
                width: widget.cirleSize,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == index
                        ? AppColors.secondaryColor
                        : null),
              ),
            ),
          ),
          Text(widget.list[index],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: widget.fontSize.sp,
                color: AppColors.grayText,
              )),
        ],
      ),
    );
  }
}
