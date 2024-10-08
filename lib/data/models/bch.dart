class Bch {
  int? bchId;
  int? bchBrandid;
  String? bchBranchName;
  int? bchBchManagerid;
  String? bchCity;
  String? bchLocation;
  String? bchLat;
  String? bchLng;
  String? bchLocationLink;
  String? bchDesc;
  String? bchImage;
  int? bchResPolicyid;
  int? bchBillPolicyid;
  String? bchContactNumber;
  int? bchIsApproved;
  int? bchIsActive;
  int? bchHomeAvailable;
  int? bchIsComplete;
  String? bchCreatetime;

  double? rate;

  int? resCount; //For trend: top res place

  Bch(
      {this.bchId,
      this.bchBrandid,
      this.bchBranchName,
      this.bchBchManagerid,
      this.bchCity,
      this.bchLocation,
      this.bchLat,
      this.bchLng,
      this.bchLocationLink,
      this.bchDesc,
      this.bchImage,
      this.bchResPolicyid,
      this.bchBillPolicyid,
      this.bchContactNumber,
      this.bchIsApproved,
      this.bchIsActive,
      this.bchHomeAvailable,
      this.bchIsComplete,
      this.bchCreatetime,
      this.rate,
      this.resCount});

  Bch.fromJson(Map<String, dynamic> json) {
    bchId = json['bch_id'];
    bchBrandid = json['bch_brandid'];
    bchBranchName = json['bch_branchName'];
    bchBchManagerid = json['bch_bchManagerid'];
    bchCity = json['bch_city'];
    bchLocation = json['bch_location'];
    bchLat = json['bch_lat'];
    bchLng = json['bch_lng'];
    bchLocationLink = json['bch_locationLink'];
    bchDesc = json['bch_desc'];
    bchImage = json['bch_image'];
    bchResPolicyid = json['bch_resPolicyid'];
    bchBillPolicyid = json['bch_billPolicyid'];
    bchContactNumber = json['bch_contactNumber'];
    bchIsApproved = json['bch_isApproved'];
    bchIsActive = json['bch_isActive'];
    bchHomeAvailable = json['bch_homeAvailable'];
    bchIsComplete = json['bch_isComplete'];
    bchCreatetime = json['bch_createtime'];
    resCount = json['resCount'];
    if (json['averageRate'] != null) {
      rate = json['averageRate'].toDouble();
    }
  }
}
