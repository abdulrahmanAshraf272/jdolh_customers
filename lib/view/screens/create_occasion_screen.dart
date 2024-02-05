import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';

class CreateOccasionScreen extends StatelessWidget {
  const CreateOccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'انشاء موعد'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'عنوان الموعد'),
          const SizedBox(height: 10),
          CustomTextField(
              textEditingController: TextEditingController(),
              hintText: 'مثال: عشاء, عيد ميلاد, ..'),
          const SizedBox(height: 10),
          const CustomSmallBoldTitle(title: 'وقت الموعد'),
          DateOrLocationDisplayContainer(
              hintText: 'اختر وقت و تاريخ الموعد',
              iconData: Icons.date_range,
              onTap: () {}),
          const SizedBox(height: 10),
          const CustomSmallBoldTitle(title: 'الموقع'),
          DateOrLocationDisplayContainer(
              hintText: 'عنوان الموعد',
              iconData: Icons.date_range,
              onTap: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: CustomSmallBoldTitle(
                  title: 'المضافين للدعوة',
                  rightPdding: 0,
                  leftPadding: 0,
                )),
                CustomButton(onTap: () {}, text: '+ أضف للدعوة')
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: 6,
              itemBuilder: (context, index) => PersonWithButtonListItem(
                name: 'عبدالرحمن',
                onTap: () {},
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BottomButton(
                    onTap: () {},
                    text: 'إنشاء موعد',
                    buttonColor: AppColors.secondaryColor,
                  )))
        ],
      ),
    );
  }
}
