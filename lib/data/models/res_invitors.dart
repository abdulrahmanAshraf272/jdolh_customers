class Resinvitors {
  int? resid;
  int? userid;
  String? userName;
  String? userImage;
  int? type;
  int? status;
  double? cost;
  int? creatorid;

  Resinvitors({
    this.resid,
    this.userid,
    this.userName,
    this.userImage,
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
    if (json['resinvitors_cost'] != null) {
      cost = json['resinvitors_cost'].toDouble();
    }
    creatorid = json['resinvitors_creatorid'];

    userName = json['user_name'];
    userImage = json['user_image'];
  }
}
