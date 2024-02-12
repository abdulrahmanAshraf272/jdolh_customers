import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/bottom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class CreateAndEditGroupScreen extends StatelessWidget {
  const CreateAndEditGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'انشاء مجموعة'),
      floatingActionButton: BottomButton(
        onTap: () {},
        text: 'حفظ',
        buttonColor: AppColors.secondaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSmallBoldTitle(
              title: 'العنوان',
              topPadding: 20,
              bottomPadding: 10,
            ),
            CustomTextField(
                textEditingController: TextEditingController(),
                hintText: 'عنوان المجموعة'),
            Row(
              children: [
                Expanded(
                  child: CustomSmallBoldTitle(
                    title: 'المضافين للمجموعة',
                    topPadding: 20,
                    bottomPadding: 20,
                  ),
                ),
                CustomButton(onTap: () {}, text: 'أضف للمجموعة'),
                SizedBox(width: 20)
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: 12,
                itemBuilder: (context, index) => PersonWithButtonListItem(
                  name: 'عبدالرحمن',
                  userName: '@abdo22',
                  image: '',
                  onTap: () {},
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
