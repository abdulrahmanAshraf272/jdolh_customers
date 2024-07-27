import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/models/bill.dart';

class BillPaymentResultController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  late Bill bill;
  late String orderId;
  BillsData billsData = BillsData(Get.find());

  String result = '';

  checkPaymentResult() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await billsData.payBillCredit(
        orderId: orderId,
        billId: bill.billId.toString(),
        amountWithoutTax: bill.billAmountWithoutTax.toString(),
        tax: bill.billTaxAmount.toString(),
        totalAmount: bill.billAmount.toString(),
        resId: bill.billResid.toString(),
        paymentMethod: bill.billPaymentMethod!,
        brandId: bill.billBrandId.toString(),
        userId: bill.billUserid.toString(),
        isOriginal: bill.isOriginal.toString());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        result = 'success';
        NotificationSender.sendToBch(
            bchid: bill.billBchId!,
            routeName: '/displayPayment',
            title: 'تم دفع فاتورة',
            body: 'فاتورة رقم ${bill.billId} من حجز رقم ${bill.billResid}');
      } else {
        result = 'failure';
        print('failure message: ${response['message']}');
      }
    }
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      bill = Get.arguments['bill'];
      orderId = Get.arguments['orderId'];
      checkPaymentResult();
    }

    super.onInit();
  }
}
