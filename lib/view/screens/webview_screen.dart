import 'package:flutter/material.dart';
import 'package:jdolh_customers/test_payment_result.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class WebviewScreen extends StatefulWidget {
  final String title;
  final String url;
  const WebviewScreen({super.key, required this.title, required this.url});

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

              //TODO: navigate to the page that display the payment result.
              //TODO: onInit result page make request to check the payment result and display the result.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TestPaymentResult(
                    orderId: 304,
                  ),
                ),
              );
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
      appBar: customAppBar(title: widget.title),
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
