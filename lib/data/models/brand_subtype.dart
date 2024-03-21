class BrandSubtype {
  int? typeId;
  String? subtype;

  BrandSubtype({this.typeId, this.subtype});

  BrandSubtype.fromJson(Map<String, dynamic> json) {
    typeId = json['subtypes_brandtypesid'];
    subtype = json['subtypes_title'];
  }
}
