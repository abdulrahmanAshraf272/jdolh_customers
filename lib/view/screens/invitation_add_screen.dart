import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class InvitationAddScreen extends StatelessWidget {
  const InvitationAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('=========ssss======');
    return Scaffold(
      appBar: customAppBar(
        title: 'اضف للدعوة',
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.gray,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) => AddGroupIconListItem(),
            ),
          ),
          SizedBox(height: 15),
          CustomTextField(
            hintText: 'ابحث في قائمة الأصدقاء',
            iconData: Icons.search,
            textEditingController: TextEditingController(),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: 6,
              itemBuilder: (context, index) => PersonWithButtonListItem(
                name: 'عبدالرحمن',
                userName: '@abdo22',
                image: '',
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddGroupIconListItem extends StatelessWidget {
  const AddGroupIconListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.groups,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor, shape: BoxShape.circle),
                  child: AutoSizeText(
                    '+',
                    maxLines: 1,
                    style: titleSmallGray.copyWith(color: Colors.white),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 3),
          Text(
            'قروب الاستراحة',
            style: titleSmall,
          )
        ],
      ),
    );
  }
}
