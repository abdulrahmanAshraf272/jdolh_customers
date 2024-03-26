import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_buttons.dart';

class PersonWithToggleListItem extends StatelessWidget {
  final String name;
  final String image;
  final void Function() onTapRemove;

  const PersonWithToggleListItem({
    super.key,
    required this.name,
    required this.image,
    required this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PersonImageAndName(
                  name: name,
                  image: 'assets/images/avatar_person.jpg',
                ),
              ),
              // Text(
              //   'منشئ الدعوة',
              //   style: titleSmall2.copyWith(color: AppColors.secondaryColor),
              // )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          CustomToggleButtons()
        ],
      ),
    );
  }
}
