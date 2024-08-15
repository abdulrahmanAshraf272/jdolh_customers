class ResLocation {
  int? reslocationId;
  int? reslocationResid;
  int? reslocationUserid;
  String? reslocationLocation;
  String? reslocationLat;
  String? reslocationLng;
  String? reslocationHood;
  String? reslocationStreet;
  String? reslocationBuilding;
  String? reslocationFloor;
  String? reslocationApartment;

  ResLocation(
      {this.reslocationId,
      this.reslocationResid,
      this.reslocationUserid,
      this.reslocationLocation,
      this.reslocationLat,
      this.reslocationLng,
      this.reslocationHood,
      this.reslocationStreet,
      this.reslocationBuilding,
      this.reslocationFloor,
      this.reslocationApartment});

  ResLocation.fromJson(Map<String, dynamic> json) {
    reslocationId = json['reslocation_id'];
    reslocationResid = json['reslocation_resid'];
    reslocationUserid = json['reslocation_userid'];
    reslocationLocation = json['reslocation_location'];
    reslocationLat = json['reslocation_lat'];
    reslocationLng = json['reslocation_lng'];
    reslocationHood = json['reslocation_hood'];
    reslocationStreet = json['reslocation_street'];
    reslocationBuilding = json['reslocation_building'];
    reslocationFloor = json['reslocation_floor'];
    reslocationApartment = json['reslocation_apartment'];
  }
}
