class BrandType {
  int? id;
  String? type;
  int? isService;

  BrandType({this.id, this.type, this.isService});

  BrandType.fromJson(Map<String, dynamic> json) {
    id = json['brandTypes_id'];
    type = json['brandTypes_type'];
    isService = json['brandTypes_isService'];
  }
}
