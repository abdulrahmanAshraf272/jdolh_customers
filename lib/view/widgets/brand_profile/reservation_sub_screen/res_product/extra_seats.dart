import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class ExtraSeats extends StatelessWidget {
  final TextEditingController textEditingController;
  const ExtraSeats({
    super.key,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          'مقاعد اضافية',
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 47,
          alignment: Alignment.center,
          //padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: textEditingController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
