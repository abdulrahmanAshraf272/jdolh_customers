import 'package:flutter/material.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_text.dart';

class ListOfInvitedPeople extends StatelessWidget {
  const ListOfInvitedPeople({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: 12,
        itemBuilder: (context, index) => PersonWithTextListItem(
              name: '',
              userName: '',
              image: '',
              onTapCard: () {},
            ));
  }
}
