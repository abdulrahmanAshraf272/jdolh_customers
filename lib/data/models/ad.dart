class Ad {
  int? adsId;
  String? image;
  String? title;
  String? desc;
  int? brandId;
  int? bchId;
  int? active;
  String? startData;
  String? endData;
  String? createDate;
  int? unlimited;
  int? clickCount;

  String? brandName;
  String? bchName;
  String? bchCity;

  Ad(
      {this.adsId,
      this.image,
      this.title,
      this.desc,
      this.brandId,
      this.bchId,
      this.active,
      this.startData,
      this.endData,
      this.unlimited,
      this.createDate,
      this.clickCount,
      this.brandName,
      this.bchName,
      this.bchCity});

  Ad.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    image = json['ads_image'];
    title = json['ads_title'];
    desc = json['ads_desc'];
    brandId = json['ads_brandid'];
    bchId = json['ads_bchid'];
    active = json['ads_active'];
    startData = json['ads_startDate'];
    endData = json['ads_endDate'];
    createDate = json['ads_createddate'];
    unlimited = json['ads_unlimited'];
    clickCount = json['ads_clickCount'];

    brandName = json['brand_storeName'];
    bchName = json['bch_branchName'];
    bchCity = json['bch_city'];
  }
}
