import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/functions/convert_time_to_arabic.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/functions/open_url_link.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:share_plus/share_plus.dart';

class PaymentResultController extends GetxController {
  BillsData billsData = BillsData(Get.find());
  late String paymentMethod;
  String reservationTime = '';
  StatusRequest statusRequest = StatusRequest.none;
  PaymentData paymentData = PaymentData(Get.find());
  MyServices myServices = Get.find();
  late Reservation reservation;
  String result = '';

  onTapShareLocation() async {
    print('${reservation.bchLocation}');
    await Share.share("${reservation.bchLocation}");
  }

  onTapDisplayLocation() {
    print('bch lat: ${reservation.bchLat}');
    print('bch lng: ${reservation.bchLng}');
    if (reservation.bchLat != null) {
      double lat = double.parse(reservation.bchLat!);
      double lng = double.parse(reservation.bchLng!);
      openLocationInGoogleMaps(lat, lng);
      //Get.toNamed(AppRouteName.diplayLocation, arguments: LatLng(lat, lng));
    }
  }

  payByCredit() async {
    String paymentMothod = myServices.getPaymentMethods();

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

    double discount = 0;
    if (reservation.resResPolicy == 1 && reservation.resPaymentType == 'RB') {
      discount = reservation.resResCost! + reservation.resResTax!;
    }

    statusRequest = StatusRequest.loading;
    var response = await paymentData.payByCredit(
        orderId: orderId,
        resid: resId.toString(),
        brandid: reservation.resBrandid.toString(),
        paymentType: reservation.resPaymentType!,
        userid: myServices.getUserid(),
        amount: (price + tax - discount).toString(),
        taxAmount: tax.toString(),
        paymentMethod: paymentMothod,
        discount: discount.toString());
    statusRequest = handlingData(response);
    print('statusRequies: $statusRequest');
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

  @override
  void onInit() {
    if (Get.arguments != null) {
      reservation = Get.arguments['res'];
      paymentMethod = Get.arguments['paymentMethod'];

      reservationTime = convertTimeToArabic(reservation.resTime!);
    }

    if (paymentMethod == 'credit') {
      payByCredit();
    }
    super.onInit();
  }
}
