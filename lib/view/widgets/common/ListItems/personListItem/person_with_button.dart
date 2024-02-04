import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';

class PersonWithButtonListItem extends StatelessWidget {
  final String name;
  final Function() onTap;
  final Color buttonColor;

  const PersonWithButtonListItem(
      {super.key,
      required this.name,
      required this.onTap,
      this.buttonColor = AppColors.secondaryColor});

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
              child: PersonImageAndName(
                name: 'عبدالرحمن العنزي',
                image: 'assets/images/avatar_person.jpg',
              ),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'إضافة',
                style: titleSmall2.copyWith(color: buttonColor),
              ))
        ],
      ),
    );
  }
}
