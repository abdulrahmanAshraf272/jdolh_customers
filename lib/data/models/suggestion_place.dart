class SuggestionPlace {
  String? placeId;
  String? description;
  String? type;

  SuggestionPlace({this.placeId, this.description, this.type = ''});

  SuggestionPlace.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    description = json['description'];
    type = json['types'][0];
  }
}
