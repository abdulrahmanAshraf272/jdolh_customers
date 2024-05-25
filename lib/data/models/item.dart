class Item {
  int? itemsId;
  int? itemsCategoriesid;
  int? itemsBchid;
  String? itemsTitle;
  double? itemsPrice;
  int? itemsDiscount;
  int? itemsDiscountPercentage;
  String? itemsImage;
  String? itemsDesc;
  int? itemsWithOptions;
  int? itemsDuration;
  int? itemsAlwaysAvailable;
  int? itemsActive;
  String? itemsSatTime;
  String? itemsSunTime;
  String? itemsMonTime;
  String? itemsTuesTime;
  String? itemsWedTime;
  String? itemsThursTime;
  String? itemsFriTime;

  Item({
    this.itemsId,
    this.itemsCategoriesid,
    this.itemsBchid,
    this.itemsTitle,
    this.itemsPrice,
    this.itemsDiscount,
    this.itemsDiscountPercentage,
    this.itemsImage,
    this.itemsDesc,
    this.itemsWithOptions,
    this.itemsDuration,
    this.itemsAlwaysAvailable,
    this.itemsActive,
    this.itemsSatTime,
    this.itemsSunTime,
    this.itemsMonTime,
    this.itemsTuesTime,
    this.itemsWedTime,
    this.itemsThursTime,
    this.itemsFriTime,
  });

  Item.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsCategoriesid = json['items_categoriesid'];
    itemsBchid = json['items_bchid'];
    itemsTitle = json['items_title'];
    if (json['items_price'] != null) {
      itemsPrice = json['items_price'].toDouble();
    }

    itemsDiscount = json['items_discount'];
    itemsDiscountPercentage = json['items_discountPercentage'];
    itemsImage = json['items_image'];
    itemsDesc = json['items_desc'];
    itemsWithOptions = json['items_withOptions'];
    itemsDuration = json['items_duration'];
    itemsAlwaysAvailable = json['items_alwaysAvailable'];
    itemsActive = json['items_active'];
    itemsSatTime = json['items_satTime'];
    itemsSunTime = json['items_sunTime'];
    itemsMonTime = json['items_monTime'];
    itemsTuesTime = json['items_tuesTime'];
    itemsWedTime = json['items_wedTime'];
    itemsThursTime = json['items_thursTime'];
    itemsFriTime = json['items_friTime'];
  }
}
