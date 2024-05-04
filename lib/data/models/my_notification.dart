class MyNotification {
  int? id;
  int? userid;
  String? title;
  String? body;
  String? image;
  String? route;
  int? objectid;
  String? datecreated;

  MyNotification(
      {this.id,
      this.userid,
      this.title,
      this.body,
      this.image,
      this.route,
      this.objectid,
      this.datecreated});

  MyNotification.fromJson(Map<String, dynamic> json) {
    id = json['notification_id'];
    userid = json['notification_userid'];
    title = json['notification_title'];
    body = json['notification_body'];
    image = json['notification_image'];
    route = json['notification_route'];
    objectid = json['notification_objectid'];
    datecreated = json['notification_datecreated'];
  }
}
