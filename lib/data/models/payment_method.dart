class PaymentMethod {
  int? id;
  String? title;
  int? isActive;

  PaymentMethod({this.id, this.title, this.isActive});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['paymentmethod_id'];
    title = json['paymentmethod_title'];
    isActive = json['paymentmethod_isActive'];
  }
}
