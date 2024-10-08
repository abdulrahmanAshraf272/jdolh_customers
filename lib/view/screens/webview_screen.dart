import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/data/models/bill.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String title;
  final String url;
  final String payment;

  final Brand? brand;
  final Reservation? reservation;
  final String? orderId;
  final String? amount;
  final Bill? bill;
  const WebviewScreen(
      {super.key,
      required this.title,
      required this.url,
      required this.payment,
      this.brand,
      this.reservation,
      this.orderId,
      this.bill,
      this.amount});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late String url;
  bool isLoading = true; // State variable to manage loading state
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    url = widget.url;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Print progress of the page loading
            print('Loading progress: $progress%');
          },
          onPageStarted: (String url) {
            // Set loading state to true when a new page starts loading
            setState(() {
              isLoading = true;
            });
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            isLoading = false;
            setState(() {});
            if (url.contains('term_url_3ds.php')) {
              print('url: $url');
              print(' ===== the payment process is finished ======');
              if (widget.payment == 'Reservation') {
                Get.offAllNamed(AppRouteName.paymentResult, arguments: {
                  "res": widget.reservation,
                  "paymentMethod": 'credit'
                });
              } else if (widget.payment == 'Wallet') {
                Get.offAllNamed(AppRouteName.walletChargingResult, arguments: {
                  "orderId": widget.orderId,
                  "amount": widget.amount
                });
              } else if (widget.payment == 'Bill') {
                Get.offAllNamed(AppRouteName.billPaymentResult, arguments: {
                  "orderId": widget.orderId,
                  'bill': widget.bill
                });
              }
            }
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error: ${error.response}');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigation request to: ${request.url}');
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: widget.title.tr),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading) // Show CircularProgressIndicator when loading
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
