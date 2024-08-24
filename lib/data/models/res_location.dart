class ResLocation {
  int? reslocationId;
  int? reslocationResid;
  int? reslocationUserid;
  String? reslocationLocation;
  String? reslocationCity;
  String? reslocationLat;
  String? reslocationLng;
  String? reslocationHood;
  String? reslocationStreet;
  String? reslocationShortAddress;
  String? reslocationAdditionalInfo;
  String? reslocationApartment;

  ResLocation(
      {this.reslocationId,
      this.reslocationResid,
      this.reslocationUserid,
      this.reslocationLocation,
      this.reslocationCity,
      this.reslocationLat,
      this.reslocationLng,
      this.reslocationHood,
      this.reslocationStreet,
      this.reslocationShortAddress,
      this.reslocationAdditionalInfo,
      this.reslocationApartment});

  ResLocation.fromJson(Map<String, dynamic> json) {
    reslocationId = json['reslocation_id'];
    reslocationResid = json['reslocation_resid'];
    reslocationUserid = json['reslocation_userid'];
    reslocationLocation = json['reslocation_location'];
    reslocationCity = json['reslocation_city'];
    reslocationLat = json['reslocation_lat'];
    reslocationLng = json['reslocation_lng'];
    reslocationHood = json['reslocation_hood'];
    reslocationStreet = json['reslocation_street'];
    reslocationShortAddress = json['reslocation_shortAddress'];
    reslocationAdditionalInfo = json['reslocation_additionalInfo'];
    reslocationApartment = json['reslocation_apartment'];
  }
}
