class Activity {
  int? id;
  int? userid;
  String? username;
  String? userImage;
  String? type;
  String? placeName;
  String? timedate;
  String? location;
  int? brandid;
  int? bchid;
  double? rate;
  String? comment;
  String? brandlogo;
  int? likesNo;
  int? isLiked;

  Activity(
      {this.id,
      this.userid,
      this.username,
      this.userImage,
      this.type,
      this.placeName,
      this.timedate,
      this.location,
      this.brandid,
      this.bchid,
      this.rate,
      this.comment,
      this.brandlogo,
      this.likesNo,
      this.isLiked});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    username = json['username'];
    userImage = json['userImage'];
    type = json['type'];
    placeName = json['placeName'];
    timedate = json['timedate'];
    location = json['location'];
    brandid = json['brandid'];
    bchid = json['bchid'];
    rate = json['rate']?.toDouble();
    comment = json['comment'];
    brandlogo = json['brandlogo'];
    likesNo = json['likesNo'];
    isLiked = json['isLiked'];
  }
}
