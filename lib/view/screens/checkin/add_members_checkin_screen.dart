import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/checkin/add_members_checkin_controller.dart';
import 'package:jdolh_customers/controller/occasion/add_to_occasion_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class AddMembersCheckinScreen extends StatelessWidget {
  const AddMembersCheckinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMembersCheckinController());
    return Scaffold(
        appBar: customAppBar(title: 'أضف للمجموعة'),
        floatingActionButton: GoHomeButton(
          onTap: () {
            controller.saveChanges();
          },
          text: 'حفظ',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GetBuilder<AddMembersCheckinController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: controller.searchController,
                hintText: 'البحث في قائمة الأصدقاء',
                iconData: Icons.search,
                onChange: (value) => controller.updateList(value),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 30, top: 20),
                  itemCount: controller.myfollowingFiltered.length,
                  itemBuilder: (context, index) => PersonWithButtonListItem(
                    name: controller.myfollowingFiltered[index].userName!,
                    userName:
                        controller.myfollowingFiltered[index].userUsername!,
                    image: controller.myfollowingFiltered[index].userImage!,
                    onTap: () {
                      controller.addRemoveMember(index);
                    },
                    onTapCard: () {},
                    buttonText: controller.getTextButton(index),
                    buttonColor: controller.getTextColor(index),
                  ),
                  // Add separatorBuilder
                ),
              ),
            ],
          ),
        ));
  }
}
