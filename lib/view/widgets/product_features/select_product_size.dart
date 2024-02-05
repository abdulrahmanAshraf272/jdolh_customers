import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class SelectSize extends StatefulWidget {
  const SelectSize({
    super.key,
  });

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  int selectedIndex = 0;
  List<String> list = ['كبير', 'متوسط', 'صغير'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) => toggleButtonItem(index)),
    );
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
            height: 18,
            width: 18,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.5)),
                shape: BoxShape.circle,
                color: const Color(0xffF3F3F3)),
            child: Center(
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == index
                        ? AppColors.secondaryColor
                        : null),
              ),
            ),
          ),
          Text(list[index],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.grayText,
              )),
        ],
      ),
    );
  }
}
