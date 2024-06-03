import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class PaymentData {
  Crud crud;
  PaymentData(this.crud);

  initiatePayment(
    String action,
    String orderId,
    String orderAmount,
    String orderCurrency,
    String orderDescription,
    String payerFirstName,
    String payerLastName,
    String payerAddress,
    String payerCountry,
    String payerCity,
    String payerZip,
    String payerEmail,
    String payerPhone,
    String payerIp,
  ) async {
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
      "payer_zip": payerZip,
      "payer_email": payerEmail,
      "payer_phone": payerPhone,
      "payer_ip": payerIp,
    });

    return response.fold((l) => l, (r) => r);
  }
}
