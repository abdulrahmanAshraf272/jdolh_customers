class MyCategories {
  int? id;
  String? title;

  MyCategories({
    this.id,
    this.title,
  });

  MyCategories.fromJson(Map<String, dynamic> json) {
    id = json['categories_id'];
    title = json['categories_title'];
  }
}
