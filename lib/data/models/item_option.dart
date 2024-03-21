import 'package:jdolh_customers/data/models/ioption_element.dart';

class ItemOption {
  int? id;
  int? itemid;
  String? title;
  int? priceDep;
  int? isBasic;
  int? isMultiselect;

  List<IOptionElement>? elements;

  ItemOption(
      {this.id,
      this.itemid,
      this.title,
      this.priceDep,
      this.isBasic,
      this.isMultiselect,
      this.elements});

  ItemOption.fromJson(Map<String, dynamic> json) {
    id = json['itemsoption_id'];
    itemid = json['itemsoption_itemsid'];
    title = json['itemsoption_title'];
    priceDep = json['itemsoption_priceDep'];
    isBasic = json['itemsoption_isBasic'];
    isMultiselect = json['itemsoption_isMultiselect'];
  }
}
