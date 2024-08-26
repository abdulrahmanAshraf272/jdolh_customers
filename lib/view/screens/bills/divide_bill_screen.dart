import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/divide_bill_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/personListItem/person_with_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';

class DivideBillScreen extends StatelessWidget {
  const DivideBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color textColor2 = Color(0xFF5c5c5d);
    final controller = Get.put(DivideBillController());
    return Scaffold(
      appBar: customAppBar(title: 'تقسيم الفاتورة'.tr),
      floatingActionButton: GoHomeButton(
        onTap: () => controller.onTapDivideBill(),
        text: 'تقسيم الفاتورة'.tr,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<DivideBillController>(
          builder: (controller) => Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      '${'المجموع مع الضريبة'.tr} (${controller.taxPercent}%)',
                      style: TextStyle(color: textColor2, fontSize: 12.sp),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '${controller.bill.billAmount} ريال',
                      style: TextStyle(color: textColor2, fontSize: 16.sp),
                    ),
                    const SizedBox(height: 25),
                    controller.members.isEmpty
                        ? Text(
                            textAlign: TextAlign.center,
                            'قم باختيار الاصدقاء الذي ترغب بمشاركة قيمة الفاتورة معهم'
                                .tr,
                            style: titleMedium)
                        : Text(
                            textAlign: TextAlign.center,
                            '${'ستقسم قيمة الفاتورة على'.tr} ${controller.members.length + 1} ${'افراد'.tr}\n ${'انت و'.tr} ${controller.members.length} ${'من اصدقائك'.tr}\n${'رسوم الفرد'.tr}: ${controller.calculatePriceForEach().toStringAsFixed(2)} ${'ريال'}',
                            style: titleMedium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomSmallBoldTitle(
                            title: 'الأصدقاء'.tr,
                            bottomPadding: 20,
                          ),
                        ),
                        CustomButton(
                            onTap: () {
                              controller.onTapAddMembers();
                            },
                            text: 'إضافة اصدقاء'.tr),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 70),
                        itemCount: controller.members.length,
                        itemBuilder: (context, index) =>
                            PersonWithButtonListItem(
                          horizontalPadding: 0,
                          name: controller.members[index].userName!,
                          userName: controller.members[index].userUsername!,
                          image: controller.members[index].userImage!,
                          onTap: () => controller.onTapRemoveMember(index),
                          onTapCard: () {},
                          buttonColor: AppColors.redButton,
                          buttonText: 'إزالة'.tr,
                        ),
                        // Add separatorBuilder
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
