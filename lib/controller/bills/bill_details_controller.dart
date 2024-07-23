import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/data/models/cart.dart';

class BillDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ResData resData = ResData(Get.find());
  late Bill bill;
  late double taxValue;
  late String taxPercent;
  List<Cart> carts = [];

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

  @override
  void onInit() {
    if (Get.arguments != null) {
      bill = Get.arguments;
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
