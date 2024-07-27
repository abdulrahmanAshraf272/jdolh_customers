import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/models/bill.dart';

class BillsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  BillsData billsData = BillsData(Get.find());
  MyServices myServices = Get.find();
  int displayPayedBills = 0;
  List<Bill> bills = [];
  List<Bill> billsToDisplay = [];

  onTapToggleButton(int payed) {
    displayPayedBills = payed;
    setBillsToDisplay();
    update();
  }

  onTapBill(int index) async {
    final reslut = await Get.toNamed(AppRouteName.billDetails,
        arguments: billsToDisplay[index]);
    if (reslut != null) {
      getCustomerBills();
    }
  }

  getCustomerBills() async {
    bills.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await billsData.getCustomerBills(myServices.getUserid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        bills = data.map((bill) => Bill.fromJson(bill)).toList();

        bills.removeWhere((bill) => bill.isDivided == 1);
        setBillsToDisplay();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  setBillsToDisplay() {
    billsToDisplay.clear();
    for (int i = 0; i < bills.length; i++) {
      if (bills[i].billIsPayed == displayPayedBills) {
        billsToDisplay.add(bills[i]);
      }
    }
  }

  @override
  void onInit() {
    getCustomerBills();
    super.onInit();
  }
}
