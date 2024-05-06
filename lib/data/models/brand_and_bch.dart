class BrandAndBch {
  int? brandId;
  int? brandBrandManagerid;
  String? brandStoreName;
  String? brandLogo;
  String? brandType;
  String? brandSubtype;
  int? brandIsService;
  String? brandContactNumber;
  String? brandInstagram;
  String? brandTiktok;
  String? brandSnapchat;
  String? brandFacebook;
  String? brandTwitter;
  int? brandIsVerified;
  int? brandIsApproved;
  String? brandDatecreated;

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
  int? resCount;

  BrandAndBch(
      {this.brandId,
      this.brandBrandManagerid,
      this.brandStoreName,
      this.brandLogo,
      this.brandType,
      this.brandSubtype,
      this.brandIsService,
      this.brandContactNumber,
      this.brandInstagram,
      this.brandTiktok,
      this.brandSnapchat,
      this.brandFacebook,
      this.brandTwitter,
      this.brandIsVerified,
      this.brandIsApproved,
      this.brandDatecreated,
      this.bchId,
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

  BrandAndBch.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandBrandManagerid = json['brand_brandManagerid'];
    brandStoreName = json['brand_storeName'];
    brandLogo = json['brand_logo'];
    brandType = json['brand_type'];
    brandSubtype = json['brand_subtype'];
    brandIsService = json['brand_isService'];
    brandContactNumber = json['brand_contactNumber'];
    brandInstagram = json['brand_instagram'];
    brandTiktok = json['brand_tiktok'];
    brandSnapchat = json['brand_snapchat'];
    brandFacebook = json['brand_facebook'];
    brandTwitter = json['brand_twitter'];
    brandIsVerified = json['brand_isVerified'];
    brandIsApproved = json['brand_isApproved'];
    brandDatecreated = json['brand_datecreated'];

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
