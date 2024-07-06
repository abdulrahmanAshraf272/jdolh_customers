import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/generate_code.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/data_source/remote/wallet.dart';
import 'package:jdolh_customers/view/screens/webview_screen.dart';

class WalletChargingController extends GetxController {
  WalletData walletData = WalletData(Get.find());
  TextEditingController amount = TextEditingController();
  MyServices myServices = Get.find();
  PaymentData paymentData = PaymentData(Get.find());
  final formKey = GlobalKey<FormState>();

  onTapChargeWallet() async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      //Remove 'X' after test
      String code = generateCode();
      String userid = myServices.getUserid();
      String orderId = '$userid-XW$code';

      //Amount
      double amountDouble = double.parse(amount.text);
      String amountFormatted = amountDouble.toStringAsFixed(2);

      var redirectUrl = await initiateEdfaPayment(orderId, amountFormatted);
      if (redirectUrl != null) {
        Get.to(() => WebviewScreen(
              title: 'الدفع',
              url: redirectUrl,
              payment: 'Wallet',
              orderId: orderId,
              amount: amountFormatted,
            ));
      }
    }
  }

  Future initiateEdfaPayment(String orderId, String amount) async {
    //Get fullName from sharedPrefs and get from it first and last name;
    String fullName = myServices.getName();
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0];
    String lastName = nameParts[1];

    //City
    String city = cityTranslations[myServices.getCity()] ?? 'Riyadh';

    CustomDialogs.loading();
    var response = await paymentData.initiatePayment(
        userid: myServices.getUserid(),
        orderType: 'WALLET', // ENUM(RESERVATION, WALLET)
        orderId: orderId,
        orderAmount: amount,
        orderDescription: 'charge customer wallet',
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
    amount.text = '0';
    super.onInit();
  }
}
