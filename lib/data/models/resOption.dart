class ResOption {
  int? resoptionsId;
  int? resoptionsBchid;
  String? resoptionsTitle;
  int? resoptionsCountLimit;
  int? resoptionsDuration;
  int? resoptionsAlwaysAvailable;
  int? resoptionsIsActive;
  String? resoptionsSatTime;
  String? resoptionsSunTime;
  String? resoptionsMonTime;
  String? resoptionsTuesTime;
  String? resoptionsWedTime;
  String? resoptionsThursTime;
  String? resoptionsFriTime;

  ResOption(
      {this.resoptionsId,
      this.resoptionsBchid,
      this.resoptionsTitle,
      this.resoptionsCountLimit,
      this.resoptionsDuration,
      this.resoptionsAlwaysAvailable,
      this.resoptionsIsActive,
      this.resoptionsSatTime,
      this.resoptionsSunTime,
      this.resoptionsMonTime,
      this.resoptionsTuesTime,
      this.resoptionsWedTime,
      this.resoptionsThursTime,
      this.resoptionsFriTime});

  ResOption.fromJson(Map<String, dynamic> json) {
    resoptionsId = json['resoptions_id'];
    resoptionsBchid = json['resoptions_bchid'];
    resoptionsTitle = json['resoptions_title'];
    resoptionsCountLimit = json['resoptions_countLimit'];
    resoptionsDuration = json['resoptions_duration'];
    resoptionsAlwaysAvailable = json['resoptions_alwaysAvailable'];
    resoptionsIsActive = json['resoptions_isActive'];
    resoptionsSatTime = json['resoptions_satTime'];
    resoptionsSunTime = json['resoptions_sunTime'];
    resoptionsMonTime = json['resoptions_monTime'];
    resoptionsTuesTime = json['resoptions_tuesTime'];
    resoptionsWedTime = json['resoptions_wedTime'];
    resoptionsThursTime = json['resoptions_thursTime'];
    resoptionsFriTime = json['resoptions_friTime'];
  }
}
