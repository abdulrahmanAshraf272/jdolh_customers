import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/my_contacts_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class MyContactsScreen extends StatelessWidget {
  const MyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyContactsController());
    return Scaffold(
      appBar: customAppBar(title: 'جهات الاتصال'.tr),
      body: GetBuilder<MyContactsController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.readContact == false
                ? Center(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                            Text('غير مسموح بالوصول الى جهات الاتصال لديك'.tr)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTextField(
                          textEditingController: controller.searchController,
                          hintText: 'البحث في قائمة الأصدقاء'.tr,
                          iconData: Icons.search,
                          onChange: (value) => controller.updateList(value),
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 30, top: 10),
                          itemCount: controller.users.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              PersonWithButtonListItem(
                            name: controller.users[index].userName!,
                            userName: controller.users[index].userUsername!,
                            image: controller.users[index].userImage!,
                            buttonText: controller.users[index].following!
                                ? 'الغاء المتابعة'.tr
                                : 'متابعة'.tr,
                            buttonColor: controller.users[index].following!
                                ? AppColors.redButton
                                : AppColors.secondaryColor,
                            onTap: () => controller.followUnfollow(index),
                            onTapCard: () => controller.onTapCard(index),
                          ),
                          // Add separatorBuilder
                        ),
                        CustomSmallBoldTitle(title: 'دعوة الأصدقاء'.tr),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 30, top: 10),
                            itemCount: controller.contacts.length,
                            itemBuilder: (context, index) => MyContactsListItem(
                                name: controller.contacts[index].name,
                                onTap: () => controller.sendInvitation(index),
                                phoneNumber: controller.contacts[index].number)
                            // Add separatorBuilder
                            ),
                      ],
                    ),
                  )),
      ),
    );
  }
}

class MyContactsListItem extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final Function() onTap;

  const MyContactsListItem({
    super.key,
    required this.name,
    required this.onTap,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/person4.jpg',
                        fit: BoxFit.cover,
                        height: 34.w,
                        width: 34.w,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(name,
                              maxLines: 1,
                              minFontSize: 11,
                              overflow: TextOverflow.ellipsis,
                              style: titleSmall),
                          Text(phoneNumber, style: titleSmallGray)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: onTap,
                child: Text(
                  'دعوة'.tr,
                  style: titleSmall2.copyWith(color: AppColors.secondaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
