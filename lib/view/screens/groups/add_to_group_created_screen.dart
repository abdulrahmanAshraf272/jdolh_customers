import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/add_to_group_controller.dart';
import 'package:jdolh_customers/controller/group/add_to_group_created_controller.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class AddToGroupCreatedScreen extends StatelessWidget {
  const AddToGroupCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddToGroupCreatedController());
    return Scaffold(
        appBar: customAppBar(title: 'أضف للمجموعة'),
        body: GetBuilder<AddToGroupCreatedController>(
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
                      controller.addMember(index);
                    },
                    onTapCard: () {},
                  ),
                  // Add separatorBuilder
                ),
              ),
            ],
          ),
        ));
  }
}
