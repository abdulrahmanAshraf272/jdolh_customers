class Brand {
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

  Brand(
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
      this.brandDatecreated});

  Brand.fromJson(Map<String, dynamic> json) {
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
  }
}
