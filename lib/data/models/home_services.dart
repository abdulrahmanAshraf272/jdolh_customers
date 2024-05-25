class HomeServices {
  int? id;
  int? bchid;
  double? cost;
  int? maxDistance;
  String? info;
  int? reviewRes;
  int? timeout;

  HomeServices(
      {this.id,
      this.bchid,
      this.cost,
      this.maxDistance,
      this.info,
      this.reviewRes,
      this.timeout});

  HomeServices.fromJson(Map<String, dynamic> json) {
    id = json['homeservices_id'];
    bchid = json['homeservices_bchid'];
    if (json['homeservices_cost'] != null) {
      cost = json['homeservices_cost'].toDouble();
    }

    maxDistance = json['homeservices_maxDistance'];
    info = json['homeservices_info'];
    reviewRes = json['homeservices_reviewRes'];
    timeout = json['homeservices_timeout'];
  }
}
