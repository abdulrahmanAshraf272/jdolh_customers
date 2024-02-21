class Place {
  String? fromGoogle;
  String? placeId;
  String? name;
  String? location;
  double? lat;
  double? lng;
  String? type;

  Place(
      {this.placeId, this.name, this.location, this.lat, this.lng, this.type});

  Place.fromJsonGoogle(Map<String, dynamic> json) {
    fromGoogle = '1';
    placeId = json['place_id'];
    name = json['name'];
    location = json['vicinity'];
    lat = json['geometry']['location']['lat'];
    lng = json['geometry']['location']['lng'];
    type = json['types'][0];
  }

  Place.fromJsonJdolh(Map<String, dynamic> json) {
    fromGoogle = '0';
    placeId = json['place_gmId'];
    name = json['place_name'];
    location = json['place_location'];
    lat = json['place_lat'];
    lng = json['place_lng'];
    type = json['place_type'];
  }
}
