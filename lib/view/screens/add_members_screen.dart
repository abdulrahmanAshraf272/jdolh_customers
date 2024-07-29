import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/add_members_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/view/widgets/add_group_list_item.dart';
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
                    if (controller.withGroups) const AllGroups(),
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

class AllGroups extends StatelessWidget {
  const AllGroups({
    super.key,
  });
  Color getRandomColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.amber;
      case 2:
        return Colors.purple;
      case 4:
        return Colors.indigo;
      case 5:
        return Colors.orange;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMembersController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequestGroups,
            widget: controller.groups.isNotEmpty
                ? SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.groups.length,
                        itemBuilder: (context, index) => AddGroupListItem(
                              groupName:
                                  controller.groups[index].groupName ?? '',
                              groupColor: getRandomColor(index),
                              isAdd: true,
                              onTap: () => controller.onTapAddGroup(index),
                            )),
                  )
                : const SizedBox()));
  }
}
