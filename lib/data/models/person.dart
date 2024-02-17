class Person {
  int? userId;
  String? userName;
  String? userUsername;
  String? userImage;
  bool? following;

  Person(
      {this.userId,
      this.userName,
      this.userUsername,
      this.userImage,
      this.following});

  Person.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userUsername = json['user_username'];
    userImage = json['user_image'];
  }
}
