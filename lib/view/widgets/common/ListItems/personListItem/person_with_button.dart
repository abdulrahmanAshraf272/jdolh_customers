import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';

class PersonWithButtonListItem extends StatelessWidget {
  final String name;
  final String userName;
  final String image;
  final Function() onTap;
  final Color buttonColor;
  final String buttonText;

  const PersonWithButtonListItem(
      {super.key,
      required this.name,
      required this.onTap,
      this.buttonColor = AppColors.secondaryColor,
      this.buttonText = 'إضافة',
      required this.userName,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: image == ''
                        ? Image.asset(
                            'assets/images/avatar_person.jpg',
                            height: 22.h,
                            width: 22.h,
                          )
                        : Image.network(''),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(name,
                            maxLines: 1,
                            minFontSize: 11,
                            overflow: TextOverflow.ellipsis,
                            style: titleSmall),
                        Text(userName, style: titleSmallGray)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: onTap,
              child: Text(
                buttonText,
                style: titleSmall2.copyWith(color: buttonColor),
              ))
        ],
      ),
    );
  }
}
