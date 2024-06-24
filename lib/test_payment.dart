import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/view/screens/webview_screen.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class TestPayment extends StatefulWidget {
  const TestPayment({super.key});

  @override
  State<TestPayment> createState() => _TestPaymentState();
}

class _TestPaymentState extends State<TestPayment> {
  StatusRequest statusRequest = StatusRequest.none;
  PaymentData paymentData = PaymentData(Get.find());

  onTapPay() async {
    statusRequest = StatusRequest.loading;
    setState(() {});

    String? redirectURL = await initiatePayment();
    setState(() {});
    if (redirectURL != null) {
      print('==== { redirectURL: $redirectURL} ===');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebviewScreen(title: 'الدفع', url: redirectURL),
        ),
      );
    } else {
      print('there is no redirectURL');
    }
  }

  Future initiatePayment() async {
    var response = await paymentData.initiatePayment(
        userid: '21',
        orderType: 'RESERVATION', // ENUM(RESERVATION, WALLET)
        orderId: '304',
        orderAmount: '120.00',
        orderDescription: 'orderDescription',
        payerFirstName: 'ahmed',
        payerLastName: 'ali',
        payerCity: 'jeddah',
        payerEmail: 'ahmed@gmail.com',
        payerPhone: '+066522222222');
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        String redirectUrl = response['redirect_url'];
        return redirectUrl;
      } else {
        print('status failure =======');
      }
    } else {
      print('faiure ===== $statusRequest');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'test payment'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              textColor: Colors.white,
              onPressed: () => onTapPay(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                color: Colors.blue,
                child: Text('pay'),
              ),
            ),
            const SizedBox(height: 20),
            if (statusRequest == StatusRequest.loading)
              CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
