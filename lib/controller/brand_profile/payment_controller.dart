import 'package:get/get.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/strings.dart';
import 'package:jdolh_customers/core/functions/custom_dialogs.dart';
import 'package:jdolh_customers/core/functions/handling_data_controller.dart';
import 'package:jdolh_customers/core/services/services.dart';
import 'package:jdolh_customers/data/data_source/remote/bills.dart';
import 'package:jdolh_customers/data/data_source/remote/payment.dart';
import 'package:jdolh_customers/data/data_source/remote/res.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/data/models/payment_method.dart';
import 'package:jdolh_customers/data/models/policy.dart';
import 'package:jdolh_customers/data/models/reservation.dart';
import 'package:jdolh_customers/view/screens/webview_screen.dart';

class PaymentController extends GetxController {
  num tax = 0;
  num price = 0;

  String paymentMethod = '';
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
  String desc = '';
  String orderId = '';

  double discount = 0;

  bool cashEligible = false;
  bool creditEligible = false;
  bool tamaraEligible = false;
  bool tabbyEligible = false;

  StatusRequest statusRequest = StatusRequest.none;
  BillsData billsData = BillsData(Get.find());

  List<PaymentMethod> availablePaymentMethods = [];

  getAvailablePaymentMethods() async {
    statusRequest = StatusRequest.loading;
    var response = await billsData
        .getAvailablePaymentMethods(reservation.resBchid.toString());
    statusRequest = handlingData(response);
    print('statusRequies: $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        print('bchid :${reservation.resBchid}');
        availablePaymentMethods =
            data.map((element) => PaymentMethod.fromJson(element)).toList();
        checkPaymentMethodsEligible();
      } else {
        statusRequest = StatusRequest.failure;
        print('failure message: ${response['message']}');
      }
    }
    update();
  }

  checkPaymentMethodsEligible() {
    //1- credit
    //2- تقسيط
    //3- cash
    //4- tamara
    //5- tabby
    for (int i = 0; i < availablePaymentMethods.length; i++) {
      int methodId = availablePaymentMethods[i].id!;
      if (methodId == 1) {
        if (availablePaymentMethods[i].isActive == 1) {
          creditEligible = true;
        }
      } else if (methodId == 2) {
        for (int j = 0; j < availablePaymentMethods.length; j++) {
          if (availablePaymentMethods[j].id == 4) {
            if (availablePaymentMethods[j].isActive == 1) {
              tamaraEligible = true;
            }
          } else if (availablePaymentMethods[j].id == 5) {
            if (availablePaymentMethods[j].isActive == 1) {
              tabbyEligible = true;
            }
          }
        }
      } else if (methodId == 3) {
        if (availablePaymentMethods[i].isActive == 1) {
          cashEligible = true;
        }
      }
    }
  }

  onTapPay() {
    if (paymentMethod == 'credit') {
      payByCredit();
    } else if (paymentMethod == 'wallet') {
      payByWallet();
    } else if (paymentMethod == 'tamara') {
      payTamara();
    } else if (paymentMethod == 'tabby') {
      payTabby();
    } else {
      Get.rawSnackbar(message: 'من فضلك اختر طريقة الدفع');
    }
  }

  payTabby() {
    reservation.paymentMethod = 'TABBY';
  }

  payByCredit() async {
    reservation.paymentMethod = 'CREDIT';
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

  payTamara() async {
    reservation.paymentMethod = 'TAMARA';
    var redirectUrl = await initiateEdfaPaymentByTamara();
    if (redirectUrl != null) {
      Get.to(() => WebviewScreen(
          title: 'الدفع'.tr,
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
        amount: (price + tax - discount).toStringAsFixed(2),
        taxAmount: tax.toStringAsFixed(2),
        discount: discount.toString());
    CustomDialogs.dissmissLoading();

    StatusRequest statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        CustomDialogs.success('تم الدفع'.tr);
        Get.offAllNamed(AppRouteName.paymentResult, arguments: {
          "res": reservation,
          "brand": brand,
          "paymentMethod": 'wallet'
        });
      } else {
        if (response['message'] == 'not enough money') {
          CustomDialogs.failure('لا يوجد رصيد كافي'.tr);
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

    //City
    String city = cityTranslations[myServices.getCity()] ?? 'Riyadh';

    CustomDialogs.loading();

    var response = await paymentData.initiatePayment(
        userid: myServices.getUserid(),
        orderType: 'RESERVATION', // ENUM(RESERVATION, WALLET)
        orderId: orderId,
        orderAmount: (price + tax - discount).toStringAsFixed(2),
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

  Future initiateEdfaPaymentByTamara() async {
    //Get fullName from sharedPrefs and get from it first and last name;
    String fullName = myServices.getName();
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0];
    String lastName = nameParts[1];
    //City
    String city = cityTranslations[myServices.getCity()] ?? 'Riyadh';

    CustomDialogs.loading();
    var response = await paymentData.initiatePaymentByTamara(
        userid: myServices.getUserid(),
        shippingAmount: "0",
        taxAmount: tax.toString(),
        orderId: orderId,
        orderAmount: (price + tax - discount).toStringAsFixed(2),
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

    if (reservation.resPaymentType == 'R') {
      desc = 'payment of the reservation price include tax';
    } else {
      desc = 'payment of the reservation and bill price include tax';
    }

    //Set Order id
    int resId = reservation.resId!;

    //TODO:Remove 'X' after test
    if (reservation.resPaymentType == 'R') {
      orderId = 'XR$resId';
    } else {
      orderId = 'XRB$resId';
    }

    if (reservation.resResPolicy == 1 && reservation.resPaymentType == 'RB') {
      //To make sure resCost is not bigger than billCost
      //if resCost = 100 and billCost is 25, the payment will be 25 - 100 = -75 which is not posible
      double resTotalCost = reservation.resResCost!;
      if (resTotalCost < reservation.resBillCost!) {
        discount = resTotalCost;
      }
    }

    getAvailablePaymentMethods();

    super.onInit();
  }
}
