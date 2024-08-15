import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/controller/bills/bills_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/bill.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/large_toggle_buttons.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BillsController());
    return Scaffold(
        appBar: customAppBar(title: 'الفواتير'.tr),
        body: GetBuilder<BillsController>(
            builder: (controller) => RefreshIndicator(
                  onRefresh: () async {
                    controller.getCustomerBills();
                  },
                  child: Column(
                    children: [
                      LargeToggleButtons(
                        optionOne: 'غير مدفوعة'.tr,
                        optionTwo: 'مدفوعة'.tr,
                        onTapOne: () => controller.onTapToggleButton(0),
                        onTapTwo: () => controller.onTapToggleButton(1),
                        twoColors: false,
                      ),
                      Expanded(
                        child: HandlingDataView(
                          emptyText: '',
                          statusRequest: controller.statusRequest,
                          widget: controller.billsToDisplay.isEmpty &&
                                  controller.displayPayedBills == 0
                              ? Center(
                                  child: Text('لا توجد فواتير غير مدفوعة'.tr))
                              : controller.billsToDisplay.isEmpty &&
                                      controller.displayPayedBills == 1
                                  ? Center(
                                      child: Text('لا توجد فواتير مدفوعة'.tr))
                                  : ListView.builder(
                                      // shrinkWrap: true,
                                      itemCount: controller
                                          .billsToDisplay.length,
                                      itemBuilder: (context, index) =>
                                          BillListItem(
                                              bill: controller
                                                  .billsToDisplay[index],
                                              onTap: () =>
                                                  controller.onTapBill(index))),
                        ),
                      )
                    ],
                  ),
                )));
  }
}
