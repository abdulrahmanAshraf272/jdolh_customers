class Reservation {
  int? resId;
  String? resPaymentType;
  int? resUserid;
  int? resBchid;
  int? resBrandid;
  String? resDate;
  String? resTime;
  int? resDuration;

  double? resBillCost;
  double? resBillTax;
  double? resResCost;
  double? resResTax;
  double? resTotalPrice;

  int? resBillPolicy;
  int? resResPolicy;
  int? resIsHomeService;
  int? resWithInvitors;
  String? resResOption;
  String? resRejectionReason;
  int? resStatus;
  String? resDatecreated;

  int? extraSeats;
  double? creatorCost;

  String? brandName;
  String? brandLogo;
  int? bchid;
  String? bchCity;
  String? bchLat;
  String? bchLng;
  String? bchLocation;
  String? bchLocationLink;
  String? bchContactNumber;

  int? resResPayed;
  int? resBillPayed;

  //for reservation i invited to.
  String? username;
  int? creator;
  int? invitorStatus;
  double? invitorAmount;

  String? paymentMethod;

  Reservation(
      {this.resId,
      this.resPaymentType,
      this.resUserid,
      this.resBchid,
      this.resBrandid,
      this.resDate,
      this.resTime,
      this.resDuration,
      this.resBillCost,
      this.resBillTax,
      this.resResCost,
      this.resResTax,
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
      this.bchContactNumber,
      this.extraSeats,
      this.creatorCost,
      this.resResPayed,
      this.resBillPayed,
      this.username,
      this.creator,
      this.invitorStatus,
      this.invitorAmount,
      this.paymentMethod});

  Reservation.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    resPaymentType = json['res_paymentType'];
    resUserid = json['res_userid'];
    resBchid = json['res_bchid'];
    resBrandid = json['res_brandid'];
    resDate = json['res_date'];
    resTime = json['res_time'];
    resDuration = json['res_duration'];

    resBillCost = double.parse(json['res_billCost']);
    resBillTax = double.parse(json['res_billTax']);
    resResCost = double.parse(json['res_resCost']);
    resResTax = double.parse(json['res_resTax']);
    resTotalPrice = double.parse(json['res_totalPrice']);

    resBillPolicy = json['res_billPolicy'];
    resResPolicy = json['res_resPolicy'];
    resIsHomeService = json['res_isHomeService'];
    resWithInvitors = json['res_withInvitors'];
    resResOption = json['res_resOption'];
    resRejectionReason = json['res_rejectionReason'];
    resStatus = json['res_status'];
    resDatecreated = json['res_datecreated'];

    extraSeats = json['res_extraSeats'];
    creatorCost = double.parse(json['res_creatorCost']);

    brandName = json['brand_storeName'];
    brandLogo = json['brand_logo'];
    bchid = json['bch_id'];
    bchCity = json['bch_city'];
    bchLat = json['bch_lat'];
    bchLng = json['bch_lng'];
    bchLocation = json['bch_location'];
    bchLocationLink = json['bch_locationLink'];
    bchContactNumber = json['bch_contactNumber'];

    resResPayed = json['res_resPayed'];
    resBillPayed = json['res_billPayed'];

    username = json['user_name'];
    creator = json['creator'];
    invitorStatus = json['resinvitors_status'];
    if (json['amount'] != null) {
      invitorAmount = double.parse(json['amount']);
    }
  }
}
