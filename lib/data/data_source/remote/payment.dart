import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class PaymentData {
  Crud crud;
  PaymentData(this.crud);

  payByCredit(
      {required String orderId,
      required String resid,
      required String brandBouquetId,
      required String brandid,
      required String paymentType,
      required String userid,
      required String amount,
      required String taxAmount}) async {
    var response = await crud.postData(ApiLinks.payByCredit, {
      "orderId": orderId,
      "resid": resid,
      "brandBouquetId": brandBouquetId,
      "brandid": brandid,
      "paymentType": paymentType,
      "userid": userid,
      "amount": amount,
      "taxAmount": taxAmount
    });

    return response.fold((l) => l, (r) => r);
  }

  payByWallet(
      {required String resid,
      required String brandBouquetId,
      required String brandid,
      required String paymentType,
      required String userid,
      required String amount,
      required String taxAmount}) async {
    var response = await crud.postData(ApiLinks.payByWallet, {
      "resid": resid,
      "brandBouquetId": brandBouquetId,
      "brandid": brandid,
      "paymentType": paymentType,
      "userid": userid,
      "amount": amount,
      "taxAmount": taxAmount
    });

    return response.fold((l) => l, (r) => r);
  }

  initiatePayment(
      {required String userid,
      required String orderType,
      String action = 'SALE',
      required String orderId,
      required String orderAmount,
      String orderCurrency = 'SAR',
      required String orderDescription,
      required String payerFirstName,
      required String payerLastName,
      String payerAddress = 'Saudi arabia',
      String payerCountry = 'SA',
      required String payerCity,
      required String payerEmail,
      required String payerPhone,
      String auth = "N"}) async {
    var response = await crud.postData(ApiLinks.initiatePayment, {
      "userid": userid,
      "orderType": orderType,
      "action": action,
      "order_id": orderId,
      "order_amount": orderAmount,
      "order_currency": orderCurrency,
      "order_description": orderDescription,
      "payer_first_name": payerFirstName,
      "payer_last_name": payerLastName,
      "payer_address": payerAddress,
      "payer_country": payerCountry,
      "payer_city": payerCity,
      "payer_email": payerEmail,
      "payer_phone": payerPhone,
      "recurring_init": "N",
      "auth": auth,
      "term_url_3ds":
          "https://www.jdolh.com/jdolh1/jdolh_customers/payment/term_url_3ds.php",
      "req_token": "N"
    });

    return response.fold((l) => l, (r) => r);
  }

  checkPaymentResult({required String orderId}) async {
    var response = await crud.postData(ApiLinks.paymentResult, {
      "orderId": orderId,
    });

    return response.fold((l) => l, (r) => r);
  }

  initiatePaymentByTamara(
      {required String userid,
      required String orderId,
      required String orderAmount,
      required String taxAmount,
      String action = 'SALE',
      String orderCurrency = 'SAR',
      required String orderDescription,
      required String payerFirstName,
      required String payerLastName,
      String payerAddress = 'Saudi arabia',
      String payerCountry = 'SA',
      required String payerCity,
      required String payerEmail,
      required String payerPhone,
      required String shippingAmount,
      String auth = "N"}) async {
    var response = await crud.postData(ApiLinks.initiatePaymentByTamara, {
      "userid": userid,
      "order_id": orderId,
      "order_amount": orderAmount,
      "payer_country": payerCountry,
      "payer_address": payerAddress,
      "action": action,
      "order_currency": orderCurrency,
      "payer_first_name": payerFirstName,
      "payer_city": payerCity,
      "auth": auth,
      "payer_last_name": payerLastName,
      "payer_phone": payerPhone,
      "order_description": orderDescription,
      "payer_email": payerEmail,
      "term_url_3ds":
          "https://www.jdolh.com/jdolh1/jdolh_customers/payment/term_url_3ds.php",
      "tax_amount": taxAmount,
      "shipping_amount": shippingAmount,
      "expires_in_minutes": "60"
    });

    return response.fold((l) => l, (r) => r);
  }
}
