import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class AddGroupListItem extends StatelessWidget {
  final String groupName;
  final Color groupColor;
  final void Function() onTap;
  final bool isAdd;
  const AddGroupListItem({
    super.key,
    required this.groupName,
    required this.groupColor,
    required this.onTap,
    required this.isAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48.h,
            width: 48.h,
            margin: const EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: groupColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.group,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isAdd
                            ? AppColors.secondaryColor
                            : AppColors.redButton),
                    child: Icon(
                      isAdd ? Icons.add : Icons.remove,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            groupName,
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
