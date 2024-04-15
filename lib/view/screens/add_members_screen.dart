import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/add_members_controller.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';

class AddMembersScreen extends StatelessWidget {
  const AddMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddMembersController());
    return Scaffold(
        appBar: customAppBar(title: 'اضافة اصدقاء'),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GetBuilder<AddMembersController>(
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
                        itemCount: controller.following.length,
                        itemBuilder: (context, index) =>
                            PersonWithButtonListItem(
                          name: controller.following[index].userName!,
                          userName: controller.following[index].userUsername!,
                          image: controller.following[index].userImage!,
                          onTap: () => controller.onTapAdd(index),
                          onTapCard: () {},
                        ),
                        // Add separatorBuilder
                      ),
                    ),
                  ],
                )));
  }
}
