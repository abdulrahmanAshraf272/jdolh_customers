class Occasion {
  int? occasionId;
  int? occasionUserid;
  String? occasionUsername;
  String? occasionTitle;
  String? occasionDate;
  String? occasionTime;
  String? occasionLocation;
  String? occasionLat;
  String? occasionLong;
  String? occasionDatecreated;
  int? creator;
  int? acceptstatus;
  String? locationLink;

  Occasion(
      {this.occasionId,
      this.occasionUserid,
      this.occasionUsername,
      this.occasionTitle,
      this.occasionDate,
      this.occasionTime,
      this.occasionLocation,
      this.occasionLat,
      this.occasionLong,
      this.occasionDatecreated,
      this.creator,
      this.acceptstatus,
      this.locationLink});

  Occasion.fromJson(Map<String, dynamic> json) {
    occasionId = json['occasion_id'];
    occasionUserid = json['occasion_userid'];
    occasionUsername = json['occasion_username'];
    occasionTitle = json['occasion_title'];
    occasionDate = json['occasion_date'];
    occasionTime = json['occasion_time'];
    occasionLocation = json['occasion_location'];
    occasionLat = json['occasion_lat'];
    occasionLong = json['occasion_long'];
    occasionDatecreated = json['occasion_datecreated'];
    creator = json['creator'];
    acceptstatus = json['acceptstatus'];
    locationLink = json['occasion_locationLink'];
  }
}
