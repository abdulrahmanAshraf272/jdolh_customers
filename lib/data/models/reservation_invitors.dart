class Resinvitors {
  int? resid;
  int? userid;
  int? type;
  int? status;
  num? cost;
  int? creatorid;

  Resinvitors({
    this.resid,
    this.userid,
    this.type,
    this.status,
    this.cost,
    this.creatorid,
  });

  Resinvitors.fromJson(Map<String, dynamic> json) {
    resid = json['resinvitors_resid'];
    userid = json['resinvitors_userid'];
    type = json['resinvitors_type'];
    status = json['resinvitors_status'];
    cost = json['resinvitors_cost'];
    creatorid = json['resinvitors_creatorid'];
  }

  Map<String, dynamic> toJson() {
    return {
      'resid': resid,
      'userid': userid,
      'type': type,
      'status': status,
      'cost': cost,
      'creatorid': creatorid,
    };
  }
}
