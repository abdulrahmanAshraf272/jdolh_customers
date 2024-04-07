class Rate {
  int? rateId;
  int? rateResid;
  int? rateUserid;
  int? rateBrandid;
  int? rateBchid;
  double? rateRatevalue;
  String? rateComment;
  String? rateCreateddate;

  Rate(
      {this.rateId,
      this.rateResid,
      this.rateUserid,
      this.rateBrandid,
      this.rateBchid,
      this.rateRatevalue,
      this.rateComment,
      this.rateCreateddate});

  Rate.fromJson(Map<String, dynamic> json) {
    rateId = json['rate_id'];
    rateResid = json['rate_resid'];
    rateUserid = json['rate_userid'];
    rateBrandid = json['rate_brandid'];
    rateBchid = json['rate_bchid'];
    rateRatevalue = json['rate_ratevalue']?.toDouble(); // Cast to double
    rateComment = json['rate_comment'];
    rateCreateddate = json['rate_createddate'];
  }
}
