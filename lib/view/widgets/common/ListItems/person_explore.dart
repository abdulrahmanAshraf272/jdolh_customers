import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class PersonExploreListItem extends StatelessWidget {
  const PersonExploreListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 80.h,
      width: 60.h,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
            width: 60.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/avatar_person.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          AutoSizeText(
            'عبدالرحمن العنزي',
            maxLines: 2,
            style: titleSmall,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
