class Policy {
  int? id;
  String? title;

  Policy({
    this.id,
    this.title,
  });

  Policy.fromJsonRes(Map<String, dynamic> json) {
    id = json['respolicy_id'];
    title = json['respolicy_title'];
  }

  Policy.fromJsonBill(Map<String, dynamic> json) {
    id = json['billpolicy_id'];
    title = json['billpolicy_title'];
  }
}
