import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/group/groups_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/group.dart';
import 'package:jdolh_customers/view/widgets/common/appBarWithButtonCreate.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupsController());
    return GetBuilder<GroupsController>(builder: (controller) {
      print('group rebuild ======');
      return Scaffold(
          appBar: appBarWithButtonCreate(
              onTapCreate: () => controller.onTapCreateGroup(),
              onTapBack: () => Get.back(),
              title: 'المجموعات'.tr,
              buttonText: 'انشاء مجموعة'.tr),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.getAllGroups();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: controller.groups.isEmpty
                      ? Center(child: Text('لا توجد مجموعات'.tr))
                      : ListView.builder(
                          //physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 30, top: 20),
                          itemCount: controller.groups.length,
                          itemBuilder: (context, index) => GroupListItem(
                              groupName: controller.groups[index].groupName!,
                              dateCreate:
                                  controller.groups[index].groupDatecreated!,
                              isCreator: controller.groups[index].creator!,
                              onTap: () => controller.onTapGroupCard(index)),
                          // Add separatorBuilder
                        ),
                )),
              ],
            ),
          ));
    });
  }
}
