import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jdolh_customers/controller/brand_profile/set_res_time_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_customers/view/widgets/common/custom_title.dart';
import 'package:jdolh_customers/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_customers/view/widgets/common/small_time_displayer.dart';

class SetResTimeScreen extends StatelessWidget {
  const SetResTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SetResTimeController());
    return Scaffold(
        appBar: customAppBar(title: 'وقت الحجز'),
        body: GetBuilder<SetResTimeController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(title: 'اختر تاريخ الحجز'),
                      const SizedBox(height: 10),
                      DateOrLocationDisplayContainer(
                        verticalMargin: 0,
                        hintText: controller.selectedDateFormatted,
                        iconData: Icons.date_range,
                        onTap: () => controller.selectDate(context),
                      ),
                      const SizedBox(height: 20),
                      if (controller.availaleWorktime.isNotEmpty)
                        const CustomSmallBoldTitle(title: 'اختر وقت الحجز'),
                      const SizedBox(height: 20),
                      Expanded(
                          child: controller.availaleWorktime.isEmpty
                              ? Text('عفواً لا توجد اوقات متاحة في هذا اليوم')
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3,
                                  ),
                                  itemCount: controller.availaleWorktime.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  itemBuilder: (context, index) =>
                                      SmallTimeDisplayer(
                                    timeText: controller.displayTime(
                                      controller.availaleWorktime[index],
                                      context,
                                    ),
                                    onTap: () {
                                      controller.setSelectedTime(index);
                                    },
                                    isSelected:
                                        controller.checkSelectedTimeView(index),
                                  ),
                                )),
                      GoHomeButton(
                        onTap: () => controller.onTapSave(),
                        buttonColor: controller.selectedTime == ''
                            ? Colors.grey.shade300
                            : AppColors.secondaryColor,
                        text: 'حفظ',
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                )));
  }
}
