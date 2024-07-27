import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/divide_bill_controller.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
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
      appBar: customAppBar(title: 'تقسيم فاتورة'),
      floatingActionButton: GoHomeButton(
        onTap: () => controller.onTapDivideBill(),
        text: 'تقسيم الفاتورة',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<DivideBillController>(
          builder: (controller) => Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      'المجموع مع الضريبة(${controller.taxPercent}%)',
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
                            'قم باختيار الاصدقاء الذي ترغب بمشاركة قيمة الفاتورة معهم',
                            style: titleMedium)
                        : Text(
                            textAlign: TextAlign.center,
                            'ستقسم قيمة الفاتورة على ${controller.members.length + 1} افراد\n انت و ${controller.members.length} من اصدقائك\nرسوم الفرد: ${controller.calculatePriceForEach().toStringAsFixed(2)} ريال',
                            style: titleMedium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: CustomSmallBoldTitle(
                            title: 'الأصدقاء',
                            bottomPadding: 20,
                          ),
                        ),
                        CustomButton(
                            onTap: () {
                              controller.onTapAddMembers();
                            },
                            text: 'إضافة اصدقاء'),
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
                          buttonText: textRemove,
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
