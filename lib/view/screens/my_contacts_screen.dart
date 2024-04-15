import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/my_contacts_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class MyContactsScreen extends StatelessWidget {
  const MyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyContactsController());
    return Scaffold(
      appBar: customAppBar(title: 'جهات الاتصال'),
      body: GetBuilder<MyContactsController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: controller.readContact == false
                ? const Center(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('غير مسموح بالوصول الى جهات الاتصال لديك')),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 30, top: 10),
                            itemCount: controller.contacts.length,
                            itemBuilder: (context, index) => MyContactsListItem(
                                name: controller.contacts[index].name,
                                onTap: () => controller.sendInvitation(index),
                                phoneNumber: controller.contacts[index].number)
                            // Add separatorBuilder
                            ),
                      ),
                    ],
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
                  'دعوة',
                  style: titleSmall2.copyWith(color: AppColors.secondaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
