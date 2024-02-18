import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';

class PersonWithTextListItem extends StatelessWidget {
  final String name;
  final String userName;
  final String image;
  final Function()? onTapCard;
  final Color endTextColor;
  final String endText;

  const PersonWithTextListItem({
    super.key,
    required this.name,
    this.endTextColor = AppColors.secondaryColor,
    this.endText = 'إضافة',
    required this.userName,
    required this.image,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: image == ''
                                ? Image.asset(
                                    'assets/images/avatar_person.jpg',
                                    height: 34.w,
                                    width: 34.w,
                                    fit: BoxFit.cover,
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
                  Text(
                    endText,
                    style: titleSmall2.copyWith(color: endTextColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
