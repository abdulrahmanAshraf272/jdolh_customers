class PaymentCallback {
  int? paymentCallbackId;
  String? paymentCallbackAction;
  String? paymentCallbackResult;
  String? paymentCallbackStatus;
  String? paymentCallbackOrderId;
  String? paymentCallbackTransId;
  String? paymentCallbackHash;
  String? paymentCallbackTransDate;
  String? paymentCallbackCardToken;
  String? paymentCallbackCard;
  String? paymentCallbackCardExpirationDate;
  String? paymentCallbackDescriptor;
  String? paymentCallbackAmount;
  String? paymentCallbackCurrency;
  String? paymentCallbackRedirectUrl;
  String? paymentCallbackRedirectMethod;
  String? paymentCallbackDeclineReason;

  PaymentCallback(
      {this.paymentCallbackId,
      this.paymentCallbackAction,
      this.paymentCallbackResult,
      this.paymentCallbackStatus,
      this.paymentCallbackOrderId,
      this.paymentCallbackTransId,
      this.paymentCallbackHash,
      this.paymentCallbackTransDate,
      this.paymentCallbackCardToken,
      this.paymentCallbackCard,
      this.paymentCallbackCardExpirationDate,
      this.paymentCallbackDescriptor,
      this.paymentCallbackAmount,
      this.paymentCallbackCurrency,
      this.paymentCallbackRedirectUrl,
      this.paymentCallbackRedirectMethod,
      this.paymentCallbackDeclineReason});

  PaymentCallback.fromJson(Map<String, dynamic> json) {
    paymentCallbackId = json['payment_callback_id'];
    paymentCallbackAction = json['payment_callback_action'];
    paymentCallbackResult = json['payment_callback_result'];
    paymentCallbackStatus = json['payment_callback_status'];
    paymentCallbackOrderId = json['payment_callback_orderId'];
    paymentCallbackTransId = json['payment_callback_transId'];
    paymentCallbackHash = json['payment_callback_hash'];
    paymentCallbackTransDate = json['payment_callback_transDate'];
    paymentCallbackCardToken = json['payment_callback_cardToken'];
    paymentCallbackCard = json['payment_callback_card'];
    paymentCallbackCardExpirationDate =
        json['payment_callback_cardExpirationDate'];
    paymentCallbackDescriptor = json['payment_callback_descriptor'];
    paymentCallbackAmount = json['payment_callback_amount'];
    paymentCallbackCurrency = json['payment_callback_currency'];
    paymentCallbackRedirectUrl = json['payment_callback_redirectUrl'];
    paymentCallbackRedirectMethod = json['payment_callback_redirectMethod'];
    paymentCallbackDeclineReason = json['payment_callback_declineReason'];
  }
}
