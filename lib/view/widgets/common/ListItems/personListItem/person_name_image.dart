import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class PersonImageAndName extends StatelessWidget {
  final String name;
  final String image;
  const PersonImageAndName(
      {super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            image,
            height: 22.h,
            width: 22.h,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AutoSizeText(name,
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              style: titleSmall),
        ),
      ],
    );
  }
}
