class Cart {
  int? cartId;
  int? cartUserid;
  int? cartBchid;
  int? cartItemid;
  num? cartPrice;
  int? cartQuantity;
  num? cartTotalPrice;
  int? cartDiscount;
  String? cartDesc;
  String? cartShortDesc;
  int? cartResid;
  int? itemsId;
  int? itemsCategoriesid;
  int? itemsBchid;
  String? itemsTitle;
  num? itemsPrice;
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

  Cart(
      {this.cartId,
      this.cartUserid,
      this.cartBchid,
      this.cartItemid,
      this.cartPrice,
      this.cartQuantity,
      this.cartTotalPrice,
      this.cartDiscount,
      this.cartDesc,
      this.cartShortDesc,
      this.cartResid,
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
      this.itemsFriTime});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    cartUserid = json['cart_userid'];
    cartBchid = json['cart_bchid'];
    cartItemid = json['cart_itemid'];
    cartPrice = json['cart_price'];
    cartQuantity = json['cart_quantity'];
    cartTotalPrice = json['cart_totalPrice'];
    cartDiscount = json['cart_discount'];
    cartDesc = json['cart_desc'];
    cartShortDesc = json['cart_shortDesc'];
    cartResid = json['cart_resid'];
    itemsId = json['items_id'];
    itemsCategoriesid = json['items_categoriesid'];
    itemsBchid = json['items_bchid'];
    itemsTitle = json['items_title'];
    itemsPrice = json['items_price'];
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
