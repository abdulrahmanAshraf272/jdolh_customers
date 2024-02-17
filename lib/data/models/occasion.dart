class Occasion {
  int? occasionId;
  int? occasionUserid;
  String? occasionUsername;
  String? occasionTitle;
  String? occasionDatetime;
  String? occasionLocation;
  String? occasionLat;
  String? occasionLong;
  String? occasionDatecreated;
  int? creator;
  int? acceptstatus;

  Occasion(
      {this.occasionId,
      this.occasionUserid,
      this.occasionUsername,
      this.occasionTitle,
      this.occasionDatetime,
      this.occasionLocation,
      this.occasionLat,
      this.occasionLong,
      this.occasionDatecreated,
      this.creator,
      this.acceptstatus});

  Occasion.fromJson(Map<String, dynamic> json) {
    occasionId = json['occasion_id'];
    occasionUserid = json['occasion_userid'];
    occasionUsername = json['occasion_username'];
    occasionTitle = json['occasion_title'];
    occasionDatetime = json['occasion_datetime'];
    occasionLocation = json['occasion_location'];
    occasionLat = json['occasion_lat'];
    occasionLong = json['occasion_long'];
    occasionDatecreated = json['occasion_datecreated'];
    creator = json['creator'];
    acceptstatus = json['acceptstatus'];
  }
}
