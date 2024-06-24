import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/models/payment_callback.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class TestPaymentResult extends StatefulWidget {
  final int orderId;
  const TestPaymentResult({super.key, required this.orderId});

  @override
  State<TestPaymentResult> createState() => _TestPaymentResultState();
}

class _TestPaymentResultState extends State<TestPaymentResult> {
  StatusRequest statusRequest = StatusRequest.loading;
  String result = '';

  PaymentData paymentData = PaymentData(Get.find());
  checkPaymentResult(int orderId) async {
    var response =
        await paymentData.checkPaymentResult(orderId: orderId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        var data = response['data'];
        print(data);
        PaymentCallback paymentCallback = PaymentCallback.fromJson(data);
        result = paymentCallback.paymentCallbackResult ?? '';
      } else {
        result = 'failure';
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    int orderId = widget.orderId;
    checkPaymentResult(orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'payment result'),
      body: HandlingDataView(
        statusRequest: statusRequest,
        widget: Center(
          child: Text(result, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
