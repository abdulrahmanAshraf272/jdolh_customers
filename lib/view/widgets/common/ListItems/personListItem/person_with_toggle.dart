import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_name_image.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_toggle_buttons.dart';

class PersonWithToggleListItem extends StatelessWidget {
  final String name;
  final String image;
  final int type;
  final void Function() onTapDivide;
  final void Function() onTapWithoutPay;
  final void Function() onTapRemove;
  //final void Function() onTapPayFromHimself;

  const PersonWithToggleListItem({
    super.key,
    required this.name,
    required this.image,
    required this.onTapRemove,
    required this.type,
    required this.onTapDivide,
    required this.onTapWithoutPay,
    //required this.onTapPayFromHimself,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 5),
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PersonImageAndName(
                        name: name,
                        image: image,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                CustomResInvitorsToggleButtons(
                    type: type,
                    //onTapPayFromHimself: onTapPayFromHimself,
                    onTapDivide: onTapDivide,
                    onTapWithoutPay: onTapWithoutPay)
              ],
            ),
          ),
          TextButton(
              onPressed: onTapRemove,
              child: Text(
                'ازالة'.tr,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ))
        ],
      ),
    );
  }
}
