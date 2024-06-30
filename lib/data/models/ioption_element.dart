class IOptionElement {
  int? id;
  int? itemOptionId;
  String? name;
  double? price;

  IOptionElement({this.id, this.name, this.price, this.itemOptionId});

  IOptionElement.fromJson(Map<String, dynamic> json) {
    id = json['ioptionelement_id'];
    itemOptionId = json['ioptionelement_itemsoptionid'];
    name = json['ioptionelement_name'];
    price = double.parse(json['ioptionelement_price']);
  }
}
