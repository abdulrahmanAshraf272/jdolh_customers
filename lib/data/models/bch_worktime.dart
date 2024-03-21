class BchWorktime {
  int? bchworktimeId;
  int? bchworktimeBchid;
  String? bchworktimeSat;
  String? bchworktimeSun;
  String? bchworktimeMon;
  String? bchworktimeTues;
  String? bchworktimeWed;
  String? bchworktimeThurs;
  String? bchworktimeFri;

  BchWorktime(
      {this.bchworktimeId,
      this.bchworktimeBchid,
      this.bchworktimeSat,
      this.bchworktimeSun,
      this.bchworktimeMon,
      this.bchworktimeTues,
      this.bchworktimeWed,
      this.bchworktimeThurs,
      this.bchworktimeFri});

  BchWorktime.fromJson(Map<String, dynamic> json) {
    bchworktimeId = json['bchworktime_id'];
    bchworktimeBchid = json['bchworktime_bchid'];
    bchworktimeSat = json['bchworktime_sat'];
    bchworktimeSun = json['bchworktime_sun'];
    bchworktimeMon = json['bchworktime_mon'];
    bchworktimeTues = json['bchworktime_tues'];
    bchworktimeWed = json['bchworktime_wed'];
    bchworktimeThurs = json['bchworktime_thurs'];
    bchworktimeFri = json['bchworktime_fri'];
  }
}
