class ResDetails {
  int? id;
  int? bchid;
  double? cost;
  int? invitorMax;
  int? invitorMin;
  int? suspensionTimeLimit;
  String? additionalInfo;
  int? reviewRes;
  int? timeout;

  ResDetails(
      {this.id,
      this.bchid,
      this.cost,
      this.invitorMax,
      this.invitorMin,
      this.suspensionTimeLimit,
      this.additionalInfo,
      this.reviewRes,
      this.timeout});

  ResDetails.fromJson(Map<String, dynamic> json) {
    id = json['resdetails_id'];
    bchid = json['resdetails_bchid'];
    if (json['resdetails_cost'] != null) {
      cost = json['resdetails_cost'].toDouble();
    }
    invitorMax = json['resdetails_invitorMax'];
    invitorMin = json['resdetails_invitorMin'];
    suspensionTimeLimit = json['resdetails_suspensionTimeLimit'];
    additionalInfo = json['resdetails_additionalInfo'];
    reviewRes = json['resdetails_reviewRes'];
    timeout = json['resdetails_timeout'];
  }
}
