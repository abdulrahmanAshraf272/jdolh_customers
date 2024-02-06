import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class AddToGroupScreen extends StatelessWidget {
  const AddToGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'أضف للمجموعة'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CustomTextField(
            textEditingController: TextEditingController(),
            hintText: 'البحث في قائمة الأصدقاء',
            iconData: Icons.search,
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 30, top: 20),
              itemCount: 12,
              itemBuilder: (context, index) => PersonWithButtonListItem(
                name: 'عبدالرحمن',
                onTap: () {},
              ),
              // Add separatorBuilder
            ),
          ),
        ],
      ),
    );
  }
}
