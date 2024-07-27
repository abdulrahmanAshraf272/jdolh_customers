import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/data/models/cart.dart';

class BillDetailsController extends GetxController {
  String paymentMethod = '';
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());
  late Bill bill;
  late double taxValue;
  late String taxPercent;
  BillsData billsData = BillsData(Get.find());
  List<Cart> carts = [];

  Bill? originalBill;

  double priceForEach = 0;

  displayOriginalBill() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await billsData.getOriginalBill(bill.billResid.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        originalBill = Bill.fromJson(response['data']);
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  onTapDivideBill() {
    String orderDesc = generateOrderDesc();
    print(orderDesc);
    Get.toNamed(AppRouteName.divideBill, arguments: {
      "bill": bill,
      "orderDesc": orderDesc,
      "taxPercent": taxPercent
    });
  }

  onTapPay() {
    String orderDesc = generateOrderDesc();
    print(orderDesc);
    Get.toNamed(AppRouteName.selectPaymentMethod,
        arguments: {"bill": bill, "orderDesc": orderDesc});
  }

  getResCart() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resData.getResCart(resid: bill.billResid.toString());
    statusRequest = handlingData(response);

    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        carts = data.map((e) => Cart.fromJson(e)).toList();
      } else {
        print('failure');
      }
    }
    update();
  }

  generateOrderDesc() {
    String desc = '';
    for (int i = 0; i < carts.length; i++) {
      desc = '$desc${carts[i].cartQuantity} ${carts[i].itemsTitle}, ';
    }

    desc =
        '$desc\nالمجموع: ${bill.billAmountWithoutTax}\nضريبة القيمة المضافة: ${bill.billTaxAmount}\nالمجموع شامل الضريبة: ${bill.billAmount}';
    return desc;
  }

  getPaymentMethod(String? method) {
    if (method == null) return;

    switch (method) {
      case 'CASH':
        paymentMethod = 'الدفع في الفرع';
        break;
      case 'CREDIT':
        paymentMethod = 'الدفع بالبطاقة';
        break;
      case 'WALLET':
        paymentMethod = 'الدفع بالمحفظة';
        break;
      case 'TAMARA':
        paymentMethod = 'الدفع بتمارا';
        break;
      default:
        '';
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      bill = Get.arguments;
      getPaymentMethod(bill.billPaymentMethod);
      double value = double.parse(bill.billTaxPercent!);
      taxValue = value / 100;
      taxPercent = value.truncateToDouble() == value
          ? value.toInt().toString()
          : value.toString();
    }
    getResCart();
    super.onInit();
  }
}
