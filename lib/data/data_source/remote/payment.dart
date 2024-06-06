import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class PaymentData {
  Crud crud;
  PaymentData(this.crud);

  initiatePayment({
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
  }) async {
    var response = await crud.postData(ApiLinks.initiatePayment, {
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
      "term_url_3ds":
          "https://www.jdolh.com/jdolh1/jdolh_customers/payment/term_url_3ds.php",
      "req_token": "N"
    });

    return response.fold((l) => l, (r) => r);
  }
}
