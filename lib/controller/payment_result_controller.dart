import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/reservation.dart';

class PaymentResultController extends GetxController {
  late String paymentMethod;
  String reservationTime = '';
  StatusRequest statusRequest = StatusRequest.none;
  PaymentData paymentData = PaymentData(Get.find());
  MyServices myServices = Get.find();
  late Reservation reservation;
  late Brand brand;
  String result = '';

  onTapShareLocation() {}
  onTapDisplayLocation() {}

  payByCredit() async {
    String orderId;
    num price;
    num tax;
    int resId = reservation.resId!;
    if (reservation.resPaymentType == 'R') {
      orderId = 'XR$resId';
    } else {
      orderId = 'XRB$resId';
    }

    if (reservation.resPaymentType == 'R') {
      price = reservation.resResCost!;
      tax = reservation.resResTax!;
    } else {
      price = reservation.resResCost! + reservation.resBillCost!;
      tax = reservation.resResTax! + reservation.resBillTax!;
    }
    statusRequest = StatusRequest.loading;
    var response = await paymentData.payByCredit(
        orderId: orderId,
        resid: resId.toString(),
        brandBouquetId: brand.brandBouquet.toString(),
        brandid: brand.brandId.toString(),
        paymentType: reservation.resPaymentType!,
        userid: myServices.getUserid(),
        amount: (price + tax).toString(),
        taxAmount: tax.toString());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        result = 'success';
      } else {
        result = 'failure';
        String failureMessage = response['message'];
        print('failureMessage: $failureMessage');
      }
    } else {
      result = 'failure';
    }
    update();
  }

  String convertTimeToArabic(String time) {
    // Split the time string into hours and minutes
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    String minutes = parts[1];

    // Determine if it's AM or PM
    String period = hour >= 12 ? 'م' : 'ص';

    // Convert to 12-hour format
    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    // Return the formatted time string
    return '$hour:$minutes $period';
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments['res'];
      brand = Get.arguments['brand'];
      paymentMethod = Get.arguments['paymentMethod'];

      reservationTime = convertTimeToArabic(reservation.resTime!);
    }

    if (paymentMethod == 'credit') {
      payByCredit();
    }
    super.onInit();
  }
}
