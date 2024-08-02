import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/reservation_notification.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/data/models/friend.dart';

class DivideBillController extends GetxController {
  late Bill bill;
  BillsData billsData = BillsData(Get.find());
  MyServices myServices = Get.find();
  late String orderDesc;
  late String taxPercent;
  List<Friend> members = [];

  onTapAddMembers() async {
    final result = await Get.toNamed(AppRouteName.addMembers,
        arguments: {'members': members});
    if (result != null) {
      members.add(result);
      update();
    }
  }

  onTapRemoveMember(int index) {
    members.removeAt(index);
    update();
  }

  onTapDivideBill() async {
    //Get.until((route) => route.settings.name == AppRouteName.bills);
    if (members.isEmpty) {
      Get.rawSnackbar(
          message:
              'من فضلك قم باختيار الاصدقاء الذي ترغب في مشاركة الفاتورة معهم');
      return;
    }
    int membersNo = members.length + 1;
    double amountWithoutTaxForEach =
        double.parse(bill.billAmountWithoutTax!) / membersNo;
    double taxAmountForEach = double.parse(bill.billTaxAmount!) / membersNo;
    double amountForEach = double.parse(bill.billAmount!) / membersNo;

    String allUsersIds = getMembersIds();

    print('members: $allUsersIds');
    print('taxPercen: ${bill.billTaxPercent}');
    print('taxAmount: $taxAmountForEach');
    print('amountWithoutTax: $amountWithoutTaxForEach');
    print('totalAmount: $amountForEach');

    CustomDialogs.loading();
    var response = await billsData.divideBill(
        resid: bill.billResid.toString(),
        brandId: bill.billBrandId.toString(),
        bchId: bill.billBchId.toString(),
        userid: allUsersIds,
        taxPercent: bill.billTaxPercent.toString(),
        taxAmount: taxAmountForEach.toString(),
        amountWithoutTax: amountWithoutTaxForEach.toString(),
        amount: amountForEach.toString(),
        file: '',
        billId: bill.billId.toString(),
        vatNo: bill.billVatNo.toString(),
        crNo: bill.billCrNo.toString());
    CustomDialogs.dissmissLoading();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        //Send notification to friends i have divide the bill with
        ReservationNotification reservationNotification =
            ReservationNotification();
        reservationNotification.divideBillNotifications(members,
            myServices.getName(), myServices.getImage(), bill.billResid!);

        CustomDialogs.success('تم تقسيم الفاتورة');
        Get.until((route) => route.isFirst);
      } else {
        CustomDialogs.failure();
      }
    } else {
      update();
    }
  }

  double calculatePriceForEach() {
    double amount = double.parse(bill.billAmount!);
    int membersNo = members.length + 1;
    return amount / membersNo;
  }

  String getMembersIds() {
    List<int> membersIds = [];
    for (int i = 0; i < members.length; i++) {
      membersIds.add(members[i].userId!);
    }

    String idsString = membersIds.join(', ');
    idsString = '$idsString, ${myServices.getUserid()}';
    return idsString;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      bill = Get.arguments['bill'];
      orderDesc = Get.arguments['orderDesc'];
      taxPercent = Get.arguments['taxPercent'];
    }
    super.onInit();
  }
}
