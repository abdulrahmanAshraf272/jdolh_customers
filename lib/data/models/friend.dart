class Friend {
  int? userId;
  String? userName;
  String? userUsername;
  String? userImage;
  int? creator;
  int? invitorStatus;
  bool? following;

  Friend(
      {this.userId,
      this.userName,
      this.userUsername,
      this.userImage,
      this.creator,
      this.invitorStatus,
      this.following});

  Friend.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userUsername = json['user_username'];
    userImage = json['user_image'];
    creator = json['creator'];
    invitorStatus = json['invitor_status'];
    following = json['following'];
  }
}
