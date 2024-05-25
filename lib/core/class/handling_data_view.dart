import 'package:flutter/material.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView2 extends StatelessWidget {
  final StatusRequest statusRequest;
  const HandlingDataView2({super.key, required this.statusRequest});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.serverException
            ? const Center(child: Text('server exception'))
            : statusRequest == StatusRequest.unableToGetLocation
                ? const Center(child: Text('غير قارد للوصول لمكانك الحالي'))
                : statusRequest == StatusRequest.offlineFailure
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/icons/noInternetIcon.json'),
                          const Text('لا يوجد اتصال بلإنترنت')
                        ],
                      )
                    : statusRequest == StatusRequest.serverFailure
                        ? const Center(child: Text('server failure'))
                        : const Center(child: Text('لا توجد نتائج'));
  }
}

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final String emptyText;

  const HandlingDataView(
      {super.key,
      required this.statusRequest,
      required this.widget,
      this.emptyText = 'لا توجد نتائج'});

  //TODO replace the text with Lottie animation.
  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offlineFailure
            ? const Center(child: Text('لا يوجد اتصال بلإنترنت'))
            // Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Lottie.asset('assets/icons/noInternetIcon.json'),
            //       const Text('لا يوجد اتصال بلإنترنت')
            //     ],
            //   )
            : statusRequest == StatusRequest.serverFailure
                ? const Center(child: Text('server failure'))
                : statusRequest == StatusRequest.failure
                    ? Center(child: Text(emptyText))
                    : statusRequest == StatusRequest.unableToGetLocation
                        ? const Center(
                            child: Text('غير قارد للوصول لمكانك الحالي'))
                        : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  //TODO replace the text with Lottie animation.
  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offlineFailure
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/icons/noInternetIcon.json'),
                  const Text('لا يوجد اتصال بلإنترنت')
                ],
              )
            : statusRequest == StatusRequest.serverFailure
                ? const Center(child: Text('server failure'))
                : widget;
  }
}
