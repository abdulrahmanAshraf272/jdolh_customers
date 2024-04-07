class Activity {
  int? userid;
  String? username;
  String? type;
  String? placeName;
  String? timedate;
  String? location;
  int? brandid;
  int? bchid;
  int? rate;
  String? comment;
  String? brandlogo;
  int? likesNo;

  Activity(
      {this.userid,
      this.username,
      this.type,
      this.placeName,
      this.timedate,
      this.location,
      this.brandid,
      this.bchid,
      this.rate,
      this.comment,
      this.brandlogo,
      this.likesNo});

  Activity.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    type = json['type'];
    placeName = json['placeName'];
    timedate = json['timedate'];
    location = json['location'];
    brandid = json['brandid'];
    bchid = json['bchid'];
    rate = json['rate'];
    comment = json['comment'];
    brandlogo = json['brandlogo'];
    likesNo = json['likesNo'];
  }
}
