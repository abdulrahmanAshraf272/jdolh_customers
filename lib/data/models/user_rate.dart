class UserRate {
  int? userId;
  String? userName;
  String? userUsername;
  String? userImage;
  double? rateRatevalue;
  String? rateComment;

  UserRate(
      {this.userId,
      this.userName,
      this.userUsername,
      this.userImage,
      this.rateRatevalue,
      this.rateComment});

  UserRate.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userUsername = json['user_username'];
    userImage = json['user_image'];
    if (json['rate_ratevalue'] != null) {
      rateRatevalue = json['rate_ratevalue'].toDouble();
    }

    rateComment = json['rate_comment'];
  }
}
