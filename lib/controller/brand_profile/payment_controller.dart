import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/policy.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:jdolh_customers/view/screens/webview_screen.dart';

class PaymentController extends GetxController {
  num tax = 0;
  num price = 0;

  String paymentMethod = 'credit';
  PaymentData paymentData = PaymentData(Get.find());
  ResData resData = ResData(Get.find());
  MyServices myServices = Get.find();
  // StatusRequest statusRequest = StatusRequest.none;
  Reservation reservation = Reservation();
  String resPolicyText = '';
  String billPolicyText = '';
  late Policy resPolicy;
  late Policy billPolicy;

  late Brand brand;

  double resCost = 0;
  double billCost = 0;

  // onTapConfirm() {
  //   changeResStatus('3');
  //   Get.offAllNamed(AppRouteName.mainScreen);
  // }

  // changeResStatus(String status) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await resData.changeResStatus(
  //       resid: reservation.resId.toString(),
  //       status: status,
  //       rejectionReason: '');
  //   statusRequest = handlingData(response);

  //   print('statusRequest ==== $statusRequest');
  //   if (statusRequest == StatusRequest.success) {
  //     if (response['status'] == 'success') {
  //       print('success');
  //     } else {
  //       print('failure');
  //     }
  //   }
  //   update();
  // }

  onTapPay() {
    if (paymentMethod == 'credit') {
      payByCredit();
    } else {
      payByWallet();
    }
  }

  payByCredit() async {
    print('shit');
    var redirectUrl = await initiateEdfaPayment();
    if (redirectUrl != null) {
      print('shit');
      Get.to(() => WebviewScreen(
          title: 'الدفع',
          url: redirectUrl,
          payment: 'Reservation',
          reservation: reservation,
          brand: brand));
    }
  }

  payByWallet() async {
    CustomDialogs.loading();
    var response = await paymentData.payByWallet(
        resid: reservation.resId.toString(),
        brandBouquetId: brand.brandBouquet.toString(),
        brandid: brand.brandId.toString(),
        paymentType: reservation.resPaymentType!,
        userid: myServices.getUserid(),
        amount: (price + tax).toStringAsFixed(2),
        taxAmount: tax.toStringAsFixed(2));
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم الدفع');
        Get.offAllNamed(AppRouteName.paymentResult, arguments: {
          "res": reservation,
          "brand": brand,
          "paymentMethod": 'wallet'
        });
      } else {
        if (response['message'] == 'not enough money') {
          CustomDialogs.failure('لا يوجد رصيد كاف');
        } else {
          CustomDialogs.failure();
        }
      }
    } else {
      CustomDialogs.failure();
    }
  }

  Future initiateEdfaPayment() async {
    //Get fullName from sharedPrefs and get from it first and last name;
    String fullName = myServices.getName();
    print(fullName);

    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0];
    String lastName = nameParts[1];
    //Set Order id
    int resId = reservation.resId!;
    String orderId;

    //Remove 'X' after test
    if (reservation.resPaymentType == 'R') {
      orderId = 'XR$resId';
    } else {
      orderId = 'XRB$resId';
    }
    //Order Description
    String desc;
    if (reservation.resPaymentType == 'R') {
      desc = 'payment of the reservation price include tax';
    } else {
      desc = 'payment of the reservation and bill price include tax';
    }
    //City
    String city = cityTranslations[myServices.getCity()] ?? 'Riyadh';

    CustomDialogs.loading();

    var response = await paymentData.initiatePayment(
        userid: myServices.getUserid(),
        orderType: 'RESERVATION', // ENUM(RESERVATION, WALLET)
        orderId: orderId,
        orderAmount: (price + tax).toStringAsFixed(2),
        orderDescription: desc,
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
      reservation = Get.arguments['res'];
      resPolicy = Get.arguments['resPolicy'];
      billPolicy = Get.arguments['billPolicy'];
      brand = Get.arguments['brand'];

      resPolicyText = resPolicy.title ?? '';
      billPolicyText = billPolicy.title ?? '';
    } else {
      print('reserved nothing from previus screen');
    }

    if (reservation.resPaymentType == 'R') {
      price = reservation.resResCost!;
      tax = reservation.resResTax!;
    } else {
      price = reservation.resResCost! + reservation.resBillCost!;
      tax = reservation.resResTax! + reservation.resBillTax!;
    }

    super.onInit();
  }
}
