import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class DisplayDate extends StatelessWidget {
  final void Function() onTap;
  final void Function() onTapDisplayAll;
  final String selectedDate;
  const DisplayDate(
      {super.key,
      required this.onTap,
      required this.selectedDate,
      required this.onTapDisplayAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20)),
              child: AutoSizeText(
                selectedDate,
                maxLines: 1,
                style: headline4,
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: onTapDisplayAll,
            child: Text(
              'عرض الكل'.tr,
              style: TextStyle(fontSize: 12.sp),
            ))
      ],
    );
  }
}
