class TopCheckin {
  int? placeId;
  String? placeName;
  int? checkinCount;

  TopCheckin({this.placeId, this.placeName, this.checkinCount});

  TopCheckin.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    placeName = json['place_name'];
    checkinCount = json['checkinCount'];
  }
}
