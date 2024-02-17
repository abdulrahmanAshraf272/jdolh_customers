class GroupMember {
  int? userId;
  String? userName;
  String? userUsername;
  String? userImage;
  int? creator;

  GroupMember(
      {this.userId,
      this.userName,
      this.userUsername,
      this.userImage,
      this.creator});

  GroupMember.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userUsername = json['user_username'];
    userImage = json['user_image'];
    creator = json['creator'];
  }
}
