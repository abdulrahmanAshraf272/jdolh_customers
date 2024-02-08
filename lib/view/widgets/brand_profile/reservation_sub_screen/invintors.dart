import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_toggle.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';

class Invitors extends StatelessWidget {
  const Invitors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            AutoSizeText(
              'المضافين للدعوة',
              maxLines: 1,
              style: titleMedium,
            ),
            Spacer(),
            CustomButton(onTap: () {}, text: '+ أضف للدعوة'),
            SizedBox(width: 20),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: 1,
            itemBuilder: (context, index) => PersonWithToggleListItem()),
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
        ),
      ],
    );
  }
}
