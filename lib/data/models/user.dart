class User {
  int? userId;
  String? userName;
  String? userUsername;
  String? userEmail;
  String? userPhone;
  int? userGender;
  String? userCity;
  String? image;
  int? userApprove;

  User(
      {this.userId,
      this.userName,
      this.userUsername,
      this.userEmail,
      this.userPhone,
      this.userGender,
      this.userCity,
      this.image,
      this.userApprove});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userUsername = json['user_username'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userGender = json['user_gender'];
    userCity = json['user_city'];
    userApprove = json['user_approve'];
    image = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_username'] = userUsername;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['user_gender'] = userGender;
    data['user_city'] = userCity;
    data['user_approve'] = userApprove;
    return data;
  }
}
