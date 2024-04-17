class Friend {
  int? userId;
  String? userName;
  String? userUsername;
  String? userImage;
  String? phone;
  int? creator;
  int? invitorStatus;
  bool? following;
  int? count; //For trend; TOP RATE PERSON

  Friend(
      {this.userId,
      this.userName,
      this.userUsername,
      this.userImage,
      this.phone,
      this.creator,
      this.invitorStatus,
      this.following,
      this.count});

  Friend.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userUsername = json['user_username'];
    phone = json['user_phone'];
    userImage = json['user_image'];
    creator = json['creator'];
    invitorStatus = json['invitor_status'];
    following = json['following'];
    count = json['rateCount'];
  }
}
