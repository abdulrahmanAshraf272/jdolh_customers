import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/notification/notification_sender/notification_sender.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/view/screens/webview_screen.dart';

class SelectPaymentMethodController extends GetxController {
  late Bill bill;
  late String orderDesc;
  PaymentData paymentData = PaymentData(Get.find());
  MyServices myServices = Get.find();
  BillsData billsData = BillsData(Get.find());

  String selectedMethod = '';

  onTapPay() {
    if (selectedMethod == '') {
      Get.rawSnackbar(message: 'من فضلك قم باختيار طريقة الدفع'.tr);
      return;
    }

    switch (selectedMethod) {
      case 'cash':
        payCash();
        break;
      case 'credit':
        payCredit();
        break;
      case 'wallet':
        payWallet();
        break;
      case 'tamara':
        payTamara();
        break;
    }
  }

  payCash() async {
    CustomDialogs.loading();
    var response = await billsData.payBillCash(billId: bill.billId.toString());
    CustomDialogs.dissmissLoading();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        NotificationSender.sendToBch(
            bchid: bill.billBchId!,
            routeName: '/displayPayment',
            title: 'الدفع في الفرع',
            body:
                'لقد اختار استاذ ${myServices.getName()} باختيار دفع فاتورة حجز رقم ${bill.billResid} في الفرع');
        CustomDialogs.success();
        Get.offAllNamed(AppRouteName.mainScreen, arguments: {"page": 3});
        Get.toNamed(AppRouteName.bills);
      } else {
        CustomDialogs.failure();
      }
    } else {
      update();
    }
  }

  payWallet() async {
    CustomDialogs.loading();
    var response = await billsData.payBillWallet(
        userId: bill.billUserid.toString(),
        billId: bill.billId.toString(),
        amountWithoutTax: bill.billAmountWithoutTax.toString(),
        tax: bill.billTaxAmount.toString(),
        totalAmount: bill.billAmount.toString(),
        resId: bill.billResid.toString(),
        brandId: bill.billBrandId.toString(),
        isOriginal: bill.isOriginal.toString());
    CustomDialogs.dissmissLoading();
    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        NotificationSender.sendToBch(
            bchid: bill.billBchId!,
            routeName: '/displayPayment',
            title: 'تم دفع فاتورة',
            body: 'فاتورة رقم ${bill.billId} من حجز رقم ${bill.billResid}');
        CustomDialogs.success('تم دفع الفاتورة'.tr);
        Get.until((route) => route.isFirst);
      } else {
        if (response['message'] == 'not enough money') {
          CustomDialogs.failure('لا يوجد رصيد كافي'.tr);
        } else {
          CustomDialogs.failure();
        }
      }
    } else {
      update();
    }
  }

  payTamara() async {
    bill.billPaymentMethod = 'TAMARA';
    //TODO: remove x
    String orderId = '${bill.billUserid}-XXXB${bill.billResid}';
    var redirectUrl = await initiateEdfaPaymentByTamara(orderId);
    if (redirectUrl != null) {
      Get.to(() => WebviewScreen(
            title: 'الدفع'.tr,
            url: redirectUrl,
            payment: 'Bill',
            orderId: orderId,
            bill: bill,
          ));
    }
  }

  payCredit() async {
    bill.billPaymentMethod = 'CREDIT';
    //TODO: remove x
    String orderId = '${bill.billUserid}-XXB${bill.billResid}';
    var redirectUrl = await initiateEdfaPayment(orderId);
    if (redirectUrl != null) {
      print('shit');
      Get.to(() => WebviewScreen(
            title: 'الدفع'.tr,
            url: redirectUrl,
            payment: 'Bill',
            orderId: orderId,
            bill: bill,
          ));
    }
  }

  Future initiateEdfaPayment(String orderId) async {
    print('shit');
    //Get fullName from sharedPrefs and get from it first and last name;
    String fullName = myServices.getName();
    print(fullName);

    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0];
    String lastName = nameParts[1];
    //Set Order id

    //City
    String city = cityTranslations[myServices.getCity()] ?? 'Riyadh';
    CustomDialogs.loading();

    var response = await paymentData.initiatePayment(
        userid: myServices.getUserid(),
        orderType: 'RESERVATION', // ENUM(RESERVATION, WALLET)
        orderId: orderId,
        orderAmount: bill.billAmount!,
        orderDescription: orderDesc,
        payerFirstName: firstName,
        payerLastName: lastName,
        payerCity: city,
        payerEmail: myServices.getEmail(),
        payerPhone: myServices.getPhone());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    print('statusRequist: $statusRequest');
    if (statusRequest == StatusRequest.success) {
      print(response['status']);
      if (response['status'] == 'success') {
        String redirectUrl = response['redirect_url'];
        print('redirectUrl: $redirectUrl');
        return redirectUrl;
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }

  Future initiateEdfaPaymentByTamara(String orderId) async {
    //Get fullName from sharedPrefs and get from it first and last name;
    String fullName = myServices.getName();
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0];
    String lastName = nameParts[1];
    //Set Order id

    //City
    String city = cityTranslations[myServices.getCity()] ?? 'Riyadh';

    CustomDialogs.loading();

    var response = await paymentData.initiatePaymentByTamara(
        userid: myServices.getUserid(),
        shippingAmount: "0",
        taxAmount: bill.billTaxAmount.toString(),
        orderId: orderId,
        orderAmount: bill.billAmount!,
        orderDescription: orderDesc,
        payerFirstName: firstName,
        payerLastName: lastName,
        payerCity: city,
        payerEmail: myServices.getEmail(),
        payerPhone: myServices.getPhone());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    print('statusRequist: $statusRequest');
    if (statusRequest == StatusRequest.success) {
      print(response['status']);
      if (response['status'] == 'success') {
        String redirectUrl = response['redirect_url'];
        print('redirectUrl: $redirectUrl');
        return redirectUrl;
      } else {
        CustomDialogs.failure();
      }
    } else {
      CustomDialogs.failure();
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      bill = Get.arguments['bill'];
      orderDesc = Get.arguments['orderDesc'];
    }
    super.onInit();
  }
}
