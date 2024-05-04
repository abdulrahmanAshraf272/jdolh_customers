class Reservation {
  int? resId;
  int? resUserid;
  int? resBchid;
  int? resBrandid;
  String? resDate;
  String? resTime;
  int? resDuration;

  num? resPrice;
  num? resResCost;
  num? resTaxCost;
  num? resTotalPrice;

  int? resBillPolicy;
  int? resResPolicy;
  int? resIsHomeService;
  int? resWithInvitors;
  String? resResOption;
  String? resRejectionReason;
  int? resStatus;
  String? resDatecreated;

  String? brandName;
  String? brandLogo;
  int? bchid;
  String? bchCity;
  String? bchLat;
  String? bchLng;
  String? bchLocation;
  String? bchLocationLink;
  String? bchContactNumber;

  Reservation(
      {this.resId,
      this.resUserid,
      this.resBchid,
      this.resBrandid,
      this.resDate,
      this.resTime,
      this.resDuration,
      this.resPrice,
      this.resResCost,
      this.resTaxCost,
      this.resTotalPrice,
      this.resBillPolicy,
      this.resResPolicy,
      this.resIsHomeService,
      this.resWithInvitors,
      this.resResOption,
      this.resRejectionReason,
      this.resStatus,
      this.resDatecreated,
      this.brandName,
      this.brandLogo,
      this.bchid,
      this.bchCity,
      this.bchLat,
      this.bchLng,
      this.bchLocation,
      this.bchLocationLink,
      this.bchContactNumber});

  Reservation.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    resUserid = json['res_userid'];
    resBchid = json['res_bchid'];
    resBrandid = json['res_brandid'];
    resDate = json['res_date'];
    resTime = json['res_time'];
    resDuration = json['res_duration'];
    resPrice = json['res_price'];
    resResCost = json['res_resCost'];
    resTaxCost = json['res_taxCost'];
    resTotalPrice = json['res_totalPrice'];
    resBillPolicy = json['res_billPolicy'];
    resResPolicy = json['res_resPolicy'];
    resIsHomeService = json['res_isHomeService'];
    resWithInvitors = json['res_withInvitors'];
    resResOption = json['res_resOption'];
    resRejectionReason = json['res_rejectionReason'];
    resStatus = json['res_status'];
    resDatecreated = json['res_datecreated'];

    brandName = json['brand_storeName'];
    brandLogo = json['brand_logo'];
    bchid = json['bch_id'];
    bchCity = json['bch_city'];
    bchLat = json['bch_lat'];
    bchLng = json['bch_lng'];
    bchLocation = json['bch_location'];
    bchLocationLink = json['bch_locationLink'];
    bchContactNumber = json['bch_contactNumber'];
  }
}
