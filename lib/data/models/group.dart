class Group {
  int? groupId;
  String? groupName;
  String? groupDatecreated;
  int? creator;

  Group({this.groupId, this.groupName, this.groupDatecreated, this.creator});

  Group.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    groupDatecreated = json['group_datecreated'];
    creator = json['creator'];
  }
}
