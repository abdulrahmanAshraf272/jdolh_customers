import 'package:flutter/material.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class FollowersAndFollowingScreen extends StatelessWidget {
  const FollowersAndFollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'المتابعين'),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              textEditingController: TextEditingController(),
              hintText: 'بحث',
              iconData: Icons.search,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: 12,
                itemBuilder: (context, index) => PersonWithButtonListItem(
                  name: 'عبدالرحمن',
                  onTap: () {},
                  buttonText: 'تابع',
                ),
                // Add separatorBuilder
              ),
            ),
          ],
        ),
      ),
    );
  }
}
